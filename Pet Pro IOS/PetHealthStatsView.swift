//
//  PetHealthStatsView.swift
//  Pet Pro IOS
//
//  Created by Asesh Nemal on 2025-06-19.
//

import SwiftUI
import Firebase
import Charts

struct PetHealthStatsView: View {
    @State private var isConnected: Bool = false
    @State private var battery: String = "--"
    @State private var temperature: String = "--"
    @State private var heartRate: String = "--"
    @State private var steps: String = "--"
    @State private var airQuality: String = "--"
    @State private var humidity: String = "--"
    @State private var lastUpdated: String = "Never"
    
    // Dummy data for charts
    @State private var temperatureData: [Double] = []
    @State private var heartRateData: [Double] = []
    @State private var stepsData: [Double] = []
    @State private var airQualityData: [Double] = []
    @State private var humidityData: [Double] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Connection Status
                HStack {
                    Text("Battery: \(battery)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Device Status:")
                        .font(.headline)
                    Image(systemName: isConnected ? "wifi" : "wifi.slash")
                        .foregroundColor(isConnected ? .green : .orange)
                    Text(isConnected ? "Connected" : "No data")
                        .foregroundColor(isConnected ? .green : .orange)
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)
                
                // Data Summary Grid
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    dataSummaryView(title: "Temperature", value: temperature)
                    dataSummaryView(title: "Heart Rate", value: heartRate)
                    dataSummaryView(title: "Steps", value: steps)
                    dataSummaryView(title: "Air Quality", value: airQuality)
                    dataSummaryView(title: "Humidity", value: humidity)
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)
                
                // Last Updated
                HStack {
                    Spacer()
                    Text("Last updated: \(lastUpdated)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // Charts placeholders
                Group {
                    chartView(title: "Temperature (°C)", data: temperatureData)
                    chartView(title: "Heart Rate (BPM)", data: heartRateData)
                    chartView(title: "Steps Count", data: stepsData)
                    chartView(title: "Air Quality Index", data: airQualityData)
                    chartView(title: "Humidity (%)", data: humidityData)
                }
            }
            .padding()
        }
        .navigationTitle("Pet Health Stats")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fetchHealthData()
        }
    }
    
    @ViewBuilder
    private func dataSummaryView(title: String, value: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.headline)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 1)
    }
    
    @ViewBuilder
    private func chartView(title: String, data: [Double]) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            if data.isEmpty {
                Text("Loading data...")
                    .foregroundColor(.gray)
                    .italic()
            } else {
                Chart {
                    ForEach(Array(data.enumerated()), id: \.offset) { index, value in
                        LineMark(
                            x: .value("Index", index),
                            y: .value("Value", value)
                        )
                    }
                }
                .frame(height: 200)
            }
        }
        .padding(.vertical)
    }
    
    private func fetchHealthData() {
        // TODO: Implement Firebase data fetching and update state variables accordingly
        // For now, simulate data loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isConnected = true
            battery = "85%"
            temperature = "22.5°C"
            heartRate = "72 BPM"
            steps = "3500"
            airQuality = "Good (45 ppm)"
            humidity = "55%"
            lastUpdated = "Apr 25, 2025"
            
            temperatureData = [21, 22, 22.5, 23, 22.8, 22.3, 22.1]
            heartRateData = [70, 72, 71, 73, 72, 74, 72]
            stepsData = [3000, 3200, 3400, 3500, 3600, 3700, 3500]
            airQualityData = [40, 42, 45, 44, 43, 46, 45]
            humidityData = [50, 52, 55, 54, 53, 56, 55]
        }
    }
}

#Preview {
    PetHealthStatsView()
}
