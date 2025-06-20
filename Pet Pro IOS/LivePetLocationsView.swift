//
//  LivePetLocationsView.swift
//  Pet Pro IOS
//
//  Created by Asesh Nemal on 2025-06-19.
//

import SwiftUI
import MapKit
import FirebaseDatabase

struct LivePetLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let timestamp: Date?
}

struct LivePetLocationsView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.9154643, longitude: 79.9742903),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    @State private var petLocations: [LivePetLocation] = []
    
    var body: some View {
        ZStack {
            Color("light_yellow").ignoresSafeArea()
            VStack {
                Map(coordinateRegion: $region, annotationItems: petLocations) { location in
                    MapMarker(coordinate: location.coordinate, tint: .red)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }
        .navigationTitle("Pet Live Locations")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: fetchPetLocation)
    }
    
    func fetchPetLocation() {
        let ref = Database.database().reference(withPath: "petcare")
        ref.observe(.value, with: { snapshot in
            var latestLocation: LivePetLocation? = nil
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter.dateFormat = "dd/MM/yyyy, HH:mm:ss"
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any],
                   let latStr = dict["Latitude"] as? String,
                   let lonStr = dict["Longitude"] as? String,
                   let latitude = Double(latStr),
                   let longitude = Double(lonStr),
                   let timestampStr = dict["timestamp"] as? String,
                   let timestamp = dateFormatter.date(from: timestampStr) {
                    let location = LivePetLocation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), timestamp: timestamp)
                    if latestLocation == nil || (location.timestamp ?? Date.distantPast) > (latestLocation?.timestamp ?? Date.distantPast) {
                        latestLocation = location
                    }
                }
            }
            DispatchQueue.main.async {
                if let latestLocation = latestLocation {
                    self.petLocations = [latestLocation]
                    self.region = MKCoordinateRegion(
                        center: latestLocation.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                    )
                } else {
                    self.petLocations = []
                }
            }
        })
    }
}

#Preview {
    LivePetLocationsView()
}
