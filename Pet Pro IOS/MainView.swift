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
    @State private var showSmartSummary = false
    @State private var showPromotionalContent = false
    
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
                    Button(action: {
                        showSmartSummary = true
                        showPromotionalContent = false
                    }) {
                        Text("Smart Summary")
                            .fontWeight(.bold)
                            .foregroundColor(showSmartSummary ? .black : .gray)
                            .frame(width: 137, alignment: .leading)
                    }
                    Button(action: {
                        showSmartSummary = false
                        showPromotionalContent = false
                    }) {
                        Text("Day Logs")
                            .foregroundColor(showSmartSummary ? .gray : .black)
                            .frame(width: 96, alignment: .leading)
                    }
                    NavigationLink(destination: LivePetLocationsView()) {
                        Text("Pet Live Location")
                            .foregroundColor(.blue)
                            .frame(alignment: .leading)
                    }
                }
                .padding(8)
                .background(Color.white)
                
                if showPromotionalContent {
                    VStack {
                        Text("Invest in your pet's health, get out pet tracker today")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .padding(16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Color.yellow
                            .frame(height: 40)
                            .overlay(
                                Text("Limited time special offer")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                                    .padding(8),
                                alignment: .leading
                            )
                        
                        Image("ad_image")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                        
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
                        
                        Text("30% discount offer")
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .padding(8)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                } else if showSmartSummary {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Pet Health Summary")
                                .font(.system(size: 22, weight: .bold))
                                .padding(.leading, 16)
                                .padding(.top, 16)
                            
                            Text("Heart Rate: 85 bpm")
                                .font(.system(size: 16))
                                .padding(.leading, 28)
                            
                            ProgressView(value: 85, total: 200)
                                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                                .frame(width: 364, height: 23)
                                .padding(.leading, 16)
                            
                            Text("Steps: 1200")
                                .font(.system(size: 16))
                                .padding(.leading, 28)
                            
                            Text("Temperature: 38°C")
                                .font(.system(size: 16))
                                .padding(.leading, 28)
                            
                            Text("Location: Park")
                                .font(.system(size: 16))
                                .padding(.leading, 28)
                            
                            Text("Alert: Pet needs rest")
                                .font(.system(size: 16))
                                .foregroundColor(.red)
                                .padding(.leading, 28)
                            
                            Spacer()
                        }
                    }
                } else {
                    DayLogCalendarView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                }
                
                Spacer()
            }
            .tabItem {
                Image(systemName: "pawprint.fill")
                Text("Pet Logs")
            }
            .tag(0)
            
            RecordsView()
                .tabItem {
                    Image(systemName: "doc.text.fill")
                    Text("Records")
                }
                .tag(1)
            
            Text("Stats View Placeholder")
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
        .onAppear {
            showPromotionalContent = true
            showSmartSummary = false
        }
    }
}

#Preview {
    MainView()
}
