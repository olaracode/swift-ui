//
//  RegisterView.swift
//  test
//
//  Created by Octavio Lara on 04/04/2025.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var auth: AuthManager
    let toggleLogin: () -> Void
    @State var errorMsg: ErrorMessage = .init()
    @State var email: String = ""
    @State var name: String = ""
    @State var password: String = ""
    @State var rememberMe: Bool = false
    var body: some View {
        VStack {

            // Login Form
            VStack(spacing: 15) {
                Text("Start today")
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
                    Task {
                        await handleRegister()
                    }
                   
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
        .toast(isPresented: $errorMsg.isShowing, message: errorMsg.message ?? "")
    }

    func handleRegister() async {
        errorMsg.clear()
        if email.isEmpty || password.isEmpty {
            errorMsg.show(msg: "All field are required")
            return
        }
        do {
            let body = RegisterBody(email: email, password: password, name: name)
            let response = try await AuthApi.register(body: body)
            auth.login(
                withToken: response.token,
                user: User(
                    email: response.email,
                    name: response.name,
                    id: response._id
                )
            )
        }catch {
            errorMsg.show(msg: "All fields are required")
        }
    }
}
#Preview {
    RegisterView(toggleLogin: {
        print("Logged in")
    })
}
