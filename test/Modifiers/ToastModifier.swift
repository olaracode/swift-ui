//
//  ToastModifier.swift
//  test
//
//  Created by Octavio Lara on 05/04/2025.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let duration: Double

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                VStack {
                    Text(message)
                        .padding()
                        .background(.black.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .animation(.easeInOut, value: isPresented)

                    Spacer()
                }
                .padding(.top, 50)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
            }
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
    mutating func show(msg: String){
        isShowing = true
        message = msg
    }
    mutating func clear(){
        isShowing = false
        message = nil
    }
}

extension View {
    func toast(isPresented: Binding<Bool>, message: String, duration: Double = 2.0) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message, duration: duration))
    }
}
