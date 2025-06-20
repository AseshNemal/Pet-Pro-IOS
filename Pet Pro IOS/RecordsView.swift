import SwiftUI

struct RecordsView: View {
    @State private var showVaccine = false
    
    var body: some View {
        ZStack {
            Color("light_yellow").ignoresSafeArea()
            VStack {
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
                
                // Tab section
                HStack(spacing: 16) {
                    Button(action: {
                        showVaccine = false
                    }) {
                        Text("Medicine and Supplements")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(showVaccine ? .gray : .black)
                            .frame(width: 197, alignment: .leading)
                    }
                    
                    Button(action: {
                        showVaccine = true
                    }) {
                        Text("Vaccine")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(showVaccine ? .black : .gray)
                            .frame(width: 156, alignment: .leading)
                    }
                }
                .padding(8)
                .background(Color.white)
                
                if showVaccine {
                    // Vaccine list
                    VStack(spacing: 16) {
                        VaccineRow(name: "Rabies Vaccine", date: "2023-03-22", status: "Completed", statusColor: .green)
                        VaccineRow(name: "Distemper Vaccine", date: "2023-06-15", status: "Pending", statusColor: .orange)
                        VaccineRow(name: "Parvovirus Vaccine", date: "2023-09-10", status: "Scheduled", statusColor: .blue)
                    }
                    .padding()
                } else {
                    // Medicine and Supplements placeholder content
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Water")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        Text("Dry Food")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        Text("Reminders")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        Text("12.0 oz")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                        Text("12.0 oz")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 16)
                }
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct VaccineRow: View {
    let name: String
    let date: String
    let status: String
    let statusColor: Color
    
    var body: some View {
        HStack {
            Text(name)
                .font(.system(size: 16))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(date)
                .font(.system(size: 14))
                .foregroundColor(.gray)
            Text(status)
                .font(.system(size: 14))
                .foregroundColor(statusColor)
                .padding(.leading, 16)
        }
    }
}

#Preview {
    RecordsView()
}
