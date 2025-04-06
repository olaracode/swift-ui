//
//  LoginView.swift
//  test
//
//  Created by Octavio Lara on 04/04/2025.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var auth: AuthManager
    
    let toggleRegister: () -> Void // Prop
    
    @State var email: String = ""
    @State var password: String = ""
    @State var rememberMe: Bool = false
    @State var reqError = ErrorMessage()
    
    var body: some View {
        VStack() {

            // Login Form
            VStack(alignment: .leading, spacing: 15) {
                Text("Welcome Back")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)

                Text("Login to your account")
                    .foregroundColor(.gray)
                    .font(.subheadline)

                TextField("Email Address", text: $email)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(10)

                VStack(alignment: .leading) {
                    Text("Forgot Password?")
                        .foregroundColor(.green)
                        .font(.footnote)
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

            
            
            HStack(alignment: .center) {
                Text("Don't have an account?")
                Button("Sign up") {
                    toggleRegister()
                }
                .foregroundColor(.green)
            }
            .padding(.bottom)
        }
        .toast(isPresented: $reqError.isShowing, message: reqError.message ?? "")
    }
    func login() async {
        reqError.clear()
        if(email.isEmpty || password.isEmpty) {
            print("Handle errors correctly")
            return
        }
        
        do {
            let body = LoginBody(email: email, password: password)
            let response = try await AuthApi.login(loginBody: body)
            
            auth.login(
                withToken: response.token,
                user: User(
                    email: response.email,
                    name: response.name,
                    id: response._id
                )
            )
            
        }
        catch AuthRequestError.invalidEmailOrPassword {
            reqError.show(msg: "Incorrect email or password")
        }
        catch ApiError.serverError {
            reqError.show(msg: "Server Error")
        }
        catch {
            reqError.show(msg: "Unknown error")
            print("Handle errors correctly")
        }
    }
}


#Preview {
    LoginView(toggleRegister: {})
}
