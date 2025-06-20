//
//  ContentView.swift
//  Pet Pro IOS
//
//  Created by Asesh Nemal on 2025-06-19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow.opacity(0.3).edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer(minLength: 150)
                    Image("image_4_removebg_preview")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 372, height: 424)
                        .padding(.horizontal, 16)
                    Spacer(minLength: 20)
                    Text("Welcome to")
                        .font(.system(size: 34, weight: .bold))
                    Text("PetPro")
                        .font(.system(size: 34, weight: .bold))
                    Spacer()
                    HStack {
                        NavigationLink(destination: LoginView()) {
                            Text("Skip")
                                .font(.system(size: 17))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .foregroundColor(.blue)
                                .background(Color.clear)
                                .cornerRadius(8)
                        }
                        Spacer()
                        NavigationLink(destination: RegistrationView()) {
                            Text("Get Start")
                                .font(.system(size: 17))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 10)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
