//
//  LivePetLocationsView.swift
//  Pet Pro IOS
//
//  Created by Asesh Nemal on 2025-06-19.
//

import SwiftUI
import MapKit

struct LivePetLocationsView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.9154643, longitude: 79.9742903),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    let petLocations = [
        PetLocation(coordinate: CLLocationCoordinate2D(latitude: 6.9154643, longitude: 79.9742903))
    ]
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, annotationItems: petLocations) { location in
                MapMarker(coordinate: location.coordinate, tint: .red)
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationTitle("Pet Live Locations")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LivePetLocationsView()
}
