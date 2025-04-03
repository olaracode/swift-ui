//
//  ListViewModel.swift
//  test
//
//  Created by Octavio Lara on 27/03/2025.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [];
        
    
    // async functions
    func getItems() async throws {
        let apiPosts: [ItemModel] = try await api.getData(endpoint: "/todos")
        DispatchQueue.main.async {
            self.setItems(newItems: apiPosts)
        }
        
    }
    
    func postTodo(title: String) async throws {
        let newTodo = ItemModel(title: title, isCompleted: false)
        
        let createdTodo: ItemModel = try await api.postData(endpoint: "/todos", payload: newTodo)
        
        DispatchQueue.main.async {
            self.items.append(createdTodo)
        }
    }
    
    func deleteTodo(at offsets: IndexSet) async throws {
        for index in offsets {
            let todo = items[index] // get the todo item
            let endpoint = "/todos/\(todo.id)"
            try await api.deleteData(endpoint: endpoint)
            DispatchQueue.main.async {
                self.items.remove(at: index)
            }
        }
    }
    func updateTodo(todo: ItemModel) async throws {
        let endpoint = "/todos/\(todo.id)"
        let _ = try await api.putData(endpoint: endpoint, payload: todo.updateCompletion())
    }
    // Local functions
    func setItems(newItems: [ItemModel]) {
        DispatchQueue.main.async {
            self.items.append(contentsOf: newItems)
        }
    }
}

