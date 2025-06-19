import SwiftUI

struct AccountView: View {
    var body: some View {
        VStack {
            Spacer().frame(height: 40)
            
            Image("ic_profile")
                .resizable()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .padding(.top, 40)
            
            Text("Asesh Nemal")
                .font(.system(size: 24, weight: .bold))
                .padding(.top, 16)
            
            Text("aseshnemal@gmail.com")
                .font(.system(size: 18))
                .padding(.top, 8)
            
            Spacer()
            
            Button(action: {
                // Edit profile action
            }) {
                Text("Edit Profile")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 32)
            }
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

#Preview {
    AccountView()
}
