//
//  LoginView.swift
//  test
//
//  Created by Octavio Lara on 04/04/2025.
//

import SwiftUI

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    let toggleRegister: () -> Void // Prop
    
    @State var email: String = ""
    @State var password: String = ""
    @State var rememberMe: Bool = false
    @State var reqError = ErrorMessage()
    
    var body: some View {
        VStack {

            // Login Form
            VStack(spacing: 15) {
                Text("Welcome Back")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)

                Text("Login to your account")
                    .foregroundColor(.gray)
                    .font(.subheadline)

                TextField("Full Name", text: $email)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)

                VStack(alignment: .leading) {
                    Toggle("Remember Me", isOn: $rememberMe)
    
                    Text("Forgot Password?")
                        .foregroundColor(.green)
                        .font(.footnote)
                }
                if reqError.isShowing {
                    Text(reqError.message ?? "")
                        .opacity(reqError.isShowing ? 1 : 0)
                }
                Button(action: {
                    Task {
                        await login()
                    }
                   
                }) {
                    Text("Login")
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
                Text("Don't have an account?")
                Button("Sign up") {
                    toggleRegister()
                }
                .foregroundColor(.green)
            }
            .padding(.bottom)
        }
    }
    func login() async {
        if(email.isEmpty || password.isEmpty) {
            print("Handle errors correctly")
            return
        }
        
        do {
            let userBody = LoginBody(email: email, password: password)
            let newUser = try await AuthViewModel().login(loginBody: userBody)
            context.insert(newUser)
        }
        catch AuthRequestError.invalidEmailOrPassword {
            reqError.isShowing = true
            reqError.message = "Invalid email or password"
        }
        catch {
            print("Handle errors correctly")
        }
    }
}

struct ErrorMessage {
    var isShowing: Bool
    var message: String?
    
    init(){
        self.isShowing = false
        self.message = nil
    }
}
#Preview {
    LoginView(toggleRegister: {})
}
