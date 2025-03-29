# Swift Data Expense Tracker

Basic expense tracker **CRUD** using SwiftData

> SwiftData is a SwiftUI library/package that allows us to store data in the devices memory

![Expense Tracker Preview](./docs/expense-tracker.gif)

## Swift Data:

The way SwiftData works is pretty similar to the way a database would work, you need to declare a DataStructure which works as a Model to consistently save data into the devise

### Model

To create a model you need to use an struct and use the `@Model` SwiftData utility to mark it as a model

> SwiftData allows you to mark attributes as unique, optional etc

```swift
import Foundation
import SwiftData // This is required

// To create a model use @Model right above your struct
@Model
struct SomeModel {
    var property: TypeAnnotation
    // @Attribute(.unique) enforces that a field is completely unique
    @Attribute(.unique) var propertyTwo
    init(...){
        //...
    }
}
```

### Injection

To use a **SwiftData Model** you need to add it to the container and "inject" this container at entry point

```swift
import SwiftUI
import SwiftData

@main
struct testApp: App {
    // declarative container
    let container: ModelContainer = {
        let schema = Schema([Expense.self])
        let config = ModelConfiguration()
        let container = try! ModelContainer(for: schema, configurations: config)
        return container
    }()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container) // Add Container into app
        /*
            If you don't want all the bells and whistles you can simply do:
                .modelContainer(for: [...])
            to store multiple models on the container context

            to store a single model on your context you'd do:
                .modelContainer(for: Expense.self)
        */
    }
}
```

### READ

To use the SwiftData context you need to declare it at the top of the View

```swift
import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) var context
    // ...
}
```

Then you can use it to make queries and see all the elements stored on the context

```swift
import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) var context

    @Query var items: [Model]

    // get the items sorted by date
    @Query(sort: \Model.date) var sortedItems: [Model]
}
```

### CREATE

To insert data into a **SwiftData** Model you need to simply insert into the context.

> `NOTE` SwiftData has autosave feature so unlike a database you don't need to textually save, adding something into the context or updating something on the context is enough to be saves automatically

```swift
struct AddItemView: View {
    // Get the context
    @Environment(\.modelContext) private var context

    // Some example field to add into the model
    @State private var name: String = ""
    var body = some View {
        // ...
    }
    func addItem(){
        // First Create the new instance of the Model
        let newItem = Model(name: name)

        // Then insert into the context
        context.insert(newItem)

        // In case you don't trust the autosave:
        // try! context.save()
    }
}
```

### UPDATE

As mentiones on the `CREATE` the Context has autosave so you don't need to do a literal save, so updating is quire simple, you can receive the Item to update as an argument and you set it as bindable

```swift
import SwiftUI

struct UpdateExpenseSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var item: Model
    var body: some View {
        NavigationStack {
            Form {
                // Just by updating this field the item is automatically saved on
                // The memory
                TextField("Name", text: $item.name)
            }
            .navigationTitle("Update Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}
```

### Delete

To delete, similar to add you only need to do `context.delete(modelList[indexToDelete])`

```swift
import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Item.date) var items: [Item]

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    ItemCell(item: item)
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        context.delete(items[index])
                    }
                }
            }
        }
    }
}
```
