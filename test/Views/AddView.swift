//
//  AddView.swift
//  test
//
//  Created by Octavio Lara on 27/03/2025.
//

import SwiftUI

struct AddView: View {
    // this just monitors where we are on our view hierarchy
    @Environment(\.presentationMode) var presentationMode
    
    // access the global State
    @EnvironmentObject var listViewModel: ListViewModel
    
    // local state
    @State var textFieldText: String = ""
    @State var loading = false
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                
                Button(action: {
                    Task {
                        do {
                            print("Something")
                            try await saveButtonPress()
                            
                        }
                        catch {
                            print("Some error")
                        }
                       
                    }
                }, label: {
                    ZStack {
                        if loading {
                               ProgressView() // Spinner
                                   .progressViewStyle(CircularProgressViewStyle(tint: .white))
                       } else {
                           Text("Save".uppercased())
                               .foregroundColor(.white)
                               .font(.headline)
                       }
                   }
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    
                })
            }
            .padding(14)
        }
        .navigationTitle("Add an item 🖊️")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    func saveButtonPress()async throws {
        if(validateText()){
            loading = true
            do {
                try await listViewModel.postTodo(title: textFieldText)
                presentationMode.wrappedValue.dismiss()
                return
            }
            catch ApiError.badRequest {
                alertTitle = "Todo couldn't be created. Please try again later 😕(bad request)"
                showAlert.toggle()
            }
            catch {
                print("Some error")
            }
            loading = false
           
        }
        
        
    }
    func validateText() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "Your new todo item must be at least 3 characters long 😰"
            showAlert.toggle()
            return false
        }
        return true
    }
    func getAlert() -> Alert{
        return Alert(title: Text(alertTitle))
    }
}


#Preview {
    NavigationView {
        AddView()
    }
    .environmentObject(ListViewModel())
}
