import SwiftUI
import Charts
import FirebaseDatabase
import FirebaseCore

struct PetHealthStatsView: View {
    @State private var healthDataList: [HealthData] = []
    @State private var lastUpdated: String = "Last updated: Never"
    @State private var connectionStatus: ConnectionStatus = .disconnected
    
    enum ConnectionStatus {
        case connected, disconnected
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    // Connection status and summary
                    HStack {
                        Text("Device Status: ")
                            .font(.headline)
                        Image(systemName: connectionStatus == .connected ? "wifi" : "wifi.slash")
                            .foregroundColor(connectionStatus == .connected ? .green : .orange)
                        Text(connectionStatus == .connected ? "Connected" : "Historical Data")
                            .foregroundColor(connectionStatus == .connected ? .green : .orange)
                        Spacer()
                        Text(lastUpdated)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    // Summary grid
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        StatView(title: "Temperature", value: latestValue(for: \.temperature), unit: "°C")
                        StatView(title: "Heart Rate", value: latestValue(for: \.heartRate), unit: "BPM")
                        StatView(title: "Steps", value: latestValue(for: \.steps), unit: "")
                        StatView(title: "Air Quality", value: latestValue(for: \.airQuality), unit: "ppm")
                        StatView(title: "Humidity", value: latestValue(for: \.humidity), unit: "%")
                        StatView(title: "Battery", value: latestValue(for: \.battery), unit: "%")
                    }
                    .padding(.horizontal)
                    
                    // Charts
                    Group {
                        ChartView(title: "Temperature (°C)", dataPoints: healthDataList.map { $0.temperature ?? 0 })
                        ChartView(title: "Heart Rate (BPM)", dataPoints: healthDataList.map { $0.heartRate ?? 0 })
                        ChartView(title: "Steps Count", dataPoints: healthDataList.map { $0.steps ?? 0 })
                        ChartView(title: "Air Quality (ppm)", dataPoints: healthDataList.map { $0.airQuality ?? 0 })
                        ChartView(title: "Humidity (%)", dataPoints: healthDataList.map { $0.humidity ?? 0 })
                    }
                    
                    // Data table
                    VStack(alignment: .leading) {
                        Text("Recent Health Data")
                            .font(.headline)
                            .padding(.horizontal)
                        TableView(data: healthDataList)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Stats")
            .onAppear(perform: fetchHealthData)
        }
    }
    
    func latestValue(for keyPath: KeyPath<HealthData, Double?>) -> String {
        if let value = healthDataList.first?[keyPath: keyPath] {
            return String(format: "%.1f", value)
        }
        return "--"
    }
    
    func fetchHealthData() {
        let ref = Database.database().reference(withPath: "petcare")
        ref.observe(.value, with: { snapshot in
            var newData: [HealthData] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any] {
                    // Adjust keys based on actual data structure
                    let temperatureStr = dict["En_temperature"] as? String ?? dict["Temperature"] as? String
                    let temperature = Double(temperatureStr ?? "")
                    let heartRateStr = dict["hartrate"] as? String ?? dict["HeartRate"] as? String
                    let heartRate = Double(heartRateStr ?? "")
                    let stepsStr = dict["step"] as? String ?? dict["Steps"] as? String
                    let steps = Double(stepsStr ?? "")
                    let airQualityStr = dict["AirQuality"] as? String
                    let airQuality = Double(airQualityStr ?? "")
                    let humidityStr = dict["en_humidity"] as? String ?? dict["Humidity"] as? String
                    let humidity = Double(humidityStr ?? "")
                    let batteryStr = dict["Battery"] as? String
                    let battery = Double(batteryStr ?? "")
                    let timestampStr = dict["timestamp"] as? String ?? ""
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
                    dateFormatter.dateFormat = "dd/MM/yyyy, HH:mm:ss"
                    let date: Date? = dateFormatter.date(from: timestampStr)
                    let displayDateFormatter = DateFormatter()
                    displayDateFormatter.dateStyle = .medium
                    displayDateFormatter.timeStyle = .short
                    let dateString = date != nil ? displayDateFormatter.string(from: date!) : ""
                    let healthData = HealthData(
                        temperature: temperature,
                        heartRate: heartRate,
                        steps: steps,
                        airQuality: airQuality,
                        humidity: humidity,
                        battery: battery,
                        dateString: dateString,
                        date: date ?? Date.distantPast
                    )
                    newData.append(healthData)
                }
            }
            DispatchQueue.main.async {
                self.healthDataList = newData.sorted { ($0.date ?? Date.distantPast) > ($1.date ?? Date.distantPast) }
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                self.lastUpdated = "Last updated: \(formatter.string(from: Date()))"
                self.connectionStatus = .connected
            }
        }, withCancel: { error in
            print("Failed to fetch data: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.connectionStatus = .disconnected
            }
        })
    }
}

struct StatView: View {
    let title: String
    let value: String
    let unit: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("\(value) \(unit)")
                .font(.title3)
                .bold()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(10)
    }
}

struct ChartView: View {
    let title: String
    let dataPoints: [Double]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
            Chart(dataPoints, id: \.self) { point in
                LineMark(
                    x: .value("Index", dataPoints.firstIndex(of: point) ?? 0),
                    y: .value("Value", point)
                )
            }
            .frame(height: 200)
            .padding(.horizontal)
        }
    }
}

struct TableView: View {
    let data: [HealthData]
    
    var body: some View {
        ScrollView(.horizontal) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Date").bold().frame(width: 100, alignment: .leading)
                    Text("Temp (°C)").bold().frame(width: 80, alignment: .leading)
                    Text("HR (BPM)").bold().frame(width: 80, alignment: .leading)
                    Text("Air Q (ppm)").bold().frame(width: 100, alignment: .leading)
                    Text("Humidity (%)").bold().frame(width: 100, alignment: .leading)
                }
                .padding(.horizontal)
                
                ForEach(data.prefix(10).sorted { ($0.date ?? Date.distantPast) > ($1.date ?? Date.distantPast) }, id: \.id) { item in
                    HStack {
                        Text(item.dateString).frame(width: 100, alignment: .leading)
                        Text(String(format: "%.1f", item.temperature ?? 0)).frame(width: 80, alignment: .leading)
                        Text(String(format: "%.0f", item.heartRate ?? 0)).frame(width: 80, alignment: .leading)
                        Text(String(format: "%.0f", item.airQuality ?? 0)).frame(width: 100, alignment: .leading)
                        Text(String(format: "%.0f", item.humidity ?? 0)).frame(width: 100, alignment: .leading)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct HealthData: Identifiable {
    let id = UUID()
    let temperature: Double?
    let heartRate: Double?
    let steps: Double?
    let airQuality: Double?
    let humidity: Double?
    let battery: Double?
    let dateString: String
    let date: Date?
    
    static func sampleData() -> [HealthData] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return (1...10).map { i in
            HealthData(
                temperature: Double.random(in: 36...40),
                heartRate: Double.random(in: 60...100),
                steps: Double.random(in: 1000...5000),
                airQuality: Double.random(in: 10...200),
                humidity: Double.random(in: 30...70),
                battery: Double.random(in: 20...100),
                dateString: formatter.string(from: Calendar.current.date(byAdding: .day, value: -i, to: Date())!),
                date: Calendar.current.date(byAdding: .day, value: -i, to: Date())
            )
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

#Preview {
    PetHealthStatsView()
}
