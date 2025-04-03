//
//  ListView.swift
//  test
//
//  Created by Octavio Lara on 27/03/2025.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
 
    var body: some View {
        List {
            ForEach(listViewModel.items) { item in
                ListItemView(item: item)
                    .onTapGesture {
                        Task {
                            do {
                                try await listViewModel.updateTodo(todo: item)
                                DispatchQueue.main.async {
                                    withAnimation(.linear) {
                                        // Ensure UI updates happen inside the animation block
                                        if let index = listViewModel.items.firstIndex(where: { $0.id == item.id }) {
                                            listViewModel.items[index] = item.updateCompletion()
                                        }
                                    }
                                }
                            } catch {
                                print("There has been an error")
                            }
                            
                        }
                    }
            }
            .onDelete { offsets in
                Task {
                    do {
                        try await listViewModel.deleteTodo(at: offsets)
                    } catch {
                        print("Error deleting")
                    }
                }
                
            }
        }
        .navigationTitle("Todo List")
        .navigationBarItems(
            trailing: NavigationLink("Add", destination: AddView())
        )
        .task {
            if !listViewModel.items.isEmpty {
                return
            }
            do {
                try await listViewModel.getItems()
            }
            catch ApiError.invalidData{
                print("Invalid Data")
            }
            catch ApiError.serverError {
                print("There has been a server error")
            }
            catch {
                print("Should handle errors")
            }
        }
    }
    
}


#Preview {
    NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel())
}
