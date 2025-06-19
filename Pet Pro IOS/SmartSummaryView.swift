import SwiftUI

struct SmartSummaryView: View {
    var body: some View {
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
                Button("Mar") {
                    // Month button action
                }
                .frame(width: 115, height: 40)
                .background(Color("button_bg"))
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Button("22") {
                    // Day button action
                }
                .frame(height: 40)
                .background(Color("button_bg"))
                .foregroundColor(.black)
                .cornerRadius(8)
                
                Button("2025") {
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
                Text("Pet Live Location")
                    .foregroundColor(.gray)
                    .frame(alignment: .leading)
            }
            .padding(8)
            .background(Color.white)
            
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
            
            Spacer()
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    SmartSummaryView()
}
