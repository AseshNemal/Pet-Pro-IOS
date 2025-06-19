//
//  MainView.swift
//  Pet Pro IOS
//
//  Created by Asesh Nemal on 2025-06-19.
//

import SwiftUI
import MapKit

struct PetLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}

struct MainView: View {
    @State private var currentDate = Date()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.9154643, longitude: 79.9742903),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    let petLocations = [
        PetLocation(coordinate: CLLocationCoordinate2D(latitude: 6.9154643, longitude: 79.9742903))
    ]
    
    @State private var selectedTab = 0
    
    var month: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: currentDate)
    }
    
    var day: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: currentDate)
    }
    
    var year: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter.string(from: currentDate)
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            VStack(spacing: 0) {
                // Header background
                Color("light_yellow")
                    .frame(height: 120)
                    .overlay(
                        HStack {
                            Spacer()
                            Image("ic_profile")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .background(Circle().fill(Color.white))
                                .padding(8)
                                .padding(.trailing, 16)
                                .padding(.top, 16)
                        }
                    )
                
                // Date section
                HStack(spacing: 8) {
                    Button(month) {
                        // Month button action
                    }
                    .frame(width: 115, height: 40)
                    .background(Color("button_bg"))
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    
                    Button(day) {
                        // Day button action
                    }
                    .frame(height: 40)
                    .background(Color("button_bg"))
                    .foregroundColor(.black)
                    .cornerRadius(8)
                    
                    Button(year) {
                        // Year button action
                    }
                    .frame(width: 111, height: 40)
                    .background(Color("button_bg"))
                    .foregroundColor(.black)
                    .cornerRadius(8)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                
                // Tab section
                HStack(spacing: 16) {
                    Text("Smart Summary")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(width: 137, alignment: .leading)
                    Text("Day Logs")
                        .foregroundColor(.gray)
                        .frame(width: 96, alignment: .leading)
                    NavigationLink(destination: LivePetLocationsView()) {
                        Text("Pet Live Location")
                            .foregroundColor(.blue)
                            .frame(alignment: .leading)
                    }
                }
                .padding(8)
                .background(Color.white)
                
            // Map view for pet locations
            // Removed as per user request to show map only on pet live location page
//            Map(coordinateRegion: $region, annotationItems: petLocations) { location in
//                MapMarker(coordinate: location.coordinate, tint: .red)
//            }
//            .frame(height: 531)
//            .padding(.horizontal, 16)
                
                // Offer title
                Text("Invest in your pet's health, get out pet tracker today")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // Special offer banner
                Color.yellow
                    .frame(height: 40)
                    .overlay(
                        Text("Limited time special offer")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(8),
                        alignment: .leading
                    )
                
                // Ad image
                Image("ad_image")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                // Offer button
                Button(action: {
                    // Offer button action
                }) {
                    Text("Gift your pet good health")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(12)
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 16)
                
                // Discount text
                Text("30% discount offer")
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Spacer()
            }
            .tabItem {
                Image(systemName: "pawprint.fill")
                Text("Pet Logs")
            }
            .tag(0)
            
            Text("Records View Placeholder")
                .tabItem {
                    Image(systemName: "doc.text.fill")
                    Text("Records")
                }
                .tag(1)
            
            PetHealthStatsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Stats")
                }
                .tag(2)
            
            AccountView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Account")
                }
                .tag(3)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    MainView()
}
