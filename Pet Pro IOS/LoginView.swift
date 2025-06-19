//
//  LoginView.swift
//  Pet Pro IOS
//
//  Created by Asesh Nemal on 2025-06-19.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var email: String = ""
    @State private var password: String = ""

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(8)
                }
                Spacer()
            }
            .padding(.leading, 16)
            .padding(.top, 16)

            Text("Login")
                .font(.system(size: 34, weight: .bold))
                .padding(.top, 20)

            TextField("Email", text: $email)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 16)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding(.top, 40)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 16)
                .padding(.top, 16)

            NavigationLink(destination: MainView()) {
                Text("Login")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    .padding(.top, 24)
            }

            Spacer()
        }
    }
}

#Preview {
    LoginView()
}
