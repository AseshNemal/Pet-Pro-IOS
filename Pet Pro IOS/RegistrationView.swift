//
//  RegistrationView.swift
//  Pet Pro IOS
//
//  Created by Asesh Nemal on 2025-06-19.
//

import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""

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

            Text("Sign Up")
                .font(.system(size: 34, weight: .bold))
                .padding(.top, 20)

            Group {
                TextField("Full Name", text: $fullName)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    .autocapitalization(.words)

                TextField("Email", text: $email)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)

                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
            }
            .padding(.top, 16)

            Button(action: {
                // Register action
            }) {
                NavigationLink(destination: LoginView()) {
                    Text("Register")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                }
            }
            .padding(.top, 24)

            Spacer()
        }
        .background(Color("light_yellow").ignoresSafeArea())
    }
}

#Preview {
    RegistrationView()
}
