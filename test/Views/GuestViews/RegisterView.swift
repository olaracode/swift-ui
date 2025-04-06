//
//  RegisterView.swift
//  test
//
//  Created by Octavio Lara on 04/04/2025.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    let toggleLogin: () -> Void
    @State var email: String = ""
    @State var name: String = ""
    @State var password: String = ""
    @State var rememberMe: Bool = false
    var body: some View {
        VStack {

            // Login Form
            VStack(spacing: 15) {
                Text("Welcome to Plaint")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)

                Text("Create a new account")
                    .foregroundColor(.gray)
                    .font(.subheadline)

                TextField("Full Name", text: $name)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)

                
                Button(action: {
                    // Login action
                }) {
                    Text("Register")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
            }
            .padding()

            
            
            HStack {
                Text("Already have an account?")
                Button("Sign up") {
                   toggleLogin()
                }
                .foregroundColor(.green)
            }
            .padding(.bottom)
        }
    }
}
#Preview {
    RegisterView(toggleLogin: {
        print("Logged in")
    })
}
