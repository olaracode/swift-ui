//
//  InitialView.swift
//  test
//
//  Created by Octavio Lara on 05/04/2025.
//

import SwiftUI

struct InitialView: View {
    @State var activeSheet: SheetType? = nil
    var body: some View {
        ZStack(alignment: .leading) {
            Image("bg-leaf")
                .resizable()
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading) {
                if activeSheet == nil {
                    Text("Welcome to your AI Gardening Assistant")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.white)
                        .bold()
                        .multilineTextAlignment(.leading)
                        .transition(.blurReplace)

                } else {
                    Text("Welcome to Plaint")
                        .font(.system(size: 42, weight: .bold))
                        .foregroundColor(.white)
                        .bold()
                        .multilineTextAlignment(.leading)
                        .transition(.blurReplace)

                }


                Spacer()
                VStack {
                    Button(action: {
                        withAnimation {
                            activeSheet = .login
                        }
                   }) {
                       Text("Sign in")
                           .font(.headline)
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.black.opacity(0.6))
                           .foregroundColor(.white)
                           .cornerRadius(10)
                   }
                   
                   Button(action: {
                       withAnimation {
                           activeSheet = .register
                       }
                   }) {
                       Text("Create an account")
                           .foregroundColor(.white)
                           .padding(.top, 10)
                           .bold()
                   }
                }
              
                Spacer().frame(height: 40)
            }
            .padding()
     

        }
 
        .sheet(item: $activeSheet) { sheet in
               switch sheet {
               case .login:
                   LoginView(toggleRegister: toggleRegister)
                       .presentationDetents([.medium])
               case .register:
                   RegisterView(toggleLogin: toggleLogin) // Assuming you have a RegisterView
                       .presentationDetents([.medium, .large])
               }
           }
    }
    func toggleRegister(){
        activeSheet = .register
        return
    }
    func toggleLogin(){
        activeSheet = .login
        return
    }
}

enum SheetType: Identifiable {
    case login
    case register
    var id: Self { self }
    
}

#Preview {
    InitialView()
}
