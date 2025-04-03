# Todo List API

> [Created from](https://github.com/olaracode/swift-ui/tree/project/todo-list?tab=readme-ov-file#todo-list)

A continuation of the basic todo list but integrating a basic API to learn about async.

![API Todo list demo](./docs/api-todo-demo.gif)

## API class

> Is this the best approach? 🤔

To handle all the API requests, I created an `Api` class that handles the basic REST operations.

### Features

The `Api` class provides the following functionalities:

- **GET**: Fetch data from the server.
- **POST**: Send data to the server.
- **PUT**: Update data on the server.
- **DELETE**: Remove data from the server.

### Implementation Breakdown

#### Initialization

The `Api` class is initialized with a `baseUrl` that serves as the root for all API requests:

```swift
class Api {
    let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
}
```

#### URL Construction

The `getUrl` method constructs a full URL by appending the endpoint to the `baseUrl`. It throws an error if the URL is invalid:

```swift
func getUrl(endpoint: String) throws -> URL {
    guard let url = URL(string: baseUrl + endpoint) else {
        throw ApiError.invalidUrl
    }
    return url
}
```

#### Response Handling

The `processResponse` method ensures the HTTP response is valid and checks for errors based on the status code:

```swift
func processResponse(response: URLResponse) throws {
    guard let httpResponse = response as? HTTPURLResponse else {
        throw ApiError.invalidResponse
    }
    guard (200...299).contains(httpResponse.statusCode) else {
        return try processError(statusCode: httpResponse.statusCode)
    }
}

func processError(statusCode: Int) throws {
    switch statusCode {
    case 400:
        throw ApiError.badRequest
    case 404:
        throw ApiError.notFound
    default:
        throw ApiError.serverError
    }
}
```

#### JSON Decoding

The `jsonDecoder` method decodes JSON data into a specified `Codable` type:

```swift
func jsonDecoder<T: Codable>(data: Data) throws -> T {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try decoder.decode(T.self, from: data)
}
```

#### HTTP Methods

- **GET**: Fetch data from the server:

  ```swift
  func getData<T: Codable>(endpoint: String) async throws -> T {
      let url = try getUrl(endpoint: endpoint)
      let (data, response) = try await URLSession.shared.data(from: url)
      try processResponse(response: response)
      return try jsonDecoder(data: data)
  }
  ```

- **POST**: Send data to the server:

  ```swift
  func postData<T: Codable, U: Codable>(endpoint: String, payload: T) async throws -> U {
      let url = try getUrl(endpoint: endpoint)
      let request = try createRequest(url: url, payload: payload)
      let (data, response) = try await URLSession.shared.data(for: request)
      try processResponse(response: response)
      return try jsonDecoder(data: data)
  }
  ```

- **PUT**: Update data on the server:

  ```swift
  func putData<T: Codable>(endpoint: String, payload: T) async throws -> T {
      let url = try getUrl(endpoint: endpoint)
      let request = try createRequest(url: url, payload: payload, method: "PUT")
      let (data, response) = try await URLSession.shared.data(for: request)
      try processResponse(response: response)
      return try jsonDecoder(data: data)
  }
  ```

- **DELETE**: Remove data from the server:
  ```swift
  func deleteData(endpoint: String) async throws {
      let url = try getUrl(endpoint: endpoint)
      var request = URLRequest(url: url)
      request.httpMethod = "DELETE"
      let (_, response) = try await URLSession.shared.data(for: request)
      try processResponse(response: response)
  }
  ```

#### Request Creation

The `createRequest` method creates a `URLRequest` with the specified payload and HTTP method:

```swift
func createRequest<T: Codable>(url: URL, payload: T, method: String = "POST") throws -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = method
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode(payload)
    return request
}
```

#### Error Handling

The `ApiError` enum defines possible errors that can occur during API operations:

```swift
enum ApiError: Error {
    case invalidUrl
    case serverError
    case invalidResponse
    case invalidData
    case badRequest
    case notFound
}
```

### Usage

#### Initialization

To use the `Api` class, initialize it with a base URL:

```swift
let api = Api(baseUrl: "http://localhost:8080")
```

#### GET Request

Fetch data from an endpoint:

```swift
struct Todo: Codable {
    let id: Int
    let title: String
    let completed: Bool
}

Task {
    do {
        let todos: [Todo] = try await api.getData(endpoint: "/todos")
        print(todos)
    } catch {
        print("Error fetching data:", error)
    }
}
```

#### POST Request

Send data to an endpoint:

```swift
struct NewTodo: Codable {
    let title: String
    let completed: Bool
}

Task {
    do {
        let newTodo = NewTodo(title: "Learn Swift", completed: false)
        let createdTodo: Todo = try await api.postData(endpoint: "/todos", payload: newTodo)
        print(createdTodo)
    } catch {
        print("Error posting data:", error)
    }
}
```

#### PUT Request

Update data on an endpoint:

```swift
Task {
    do {
        let updatedTodo = Todo(id: 1, title: "Learn SwiftUI", completed: true)
        let result: Todo = try await api.putData(endpoint: "/todos/1", payload: updatedTodo)
        print(result)
    } catch {
        print("Error updating data:", error)
    }
}
```

#### DELETE Request

Delete data from an endpoint:

```swift
Task {
    do {
        try await api.deleteData(endpoint: "/todos/1")
        print("Todo deleted successfully")
    } catch {
        print("Error deleting data:", error)
    }
}
```

### Error Handling

The `Api` class uses the `ApiError` enum to handle errors:

- `invalidUrl`: The URL is malformed.
- `serverError`: The server returned an error.
- `invalidResponse`: The response is not valid.
- `invalidData`: The data could not be decoded.
- `badRequest`: The request was invalid (400).
- `notFound`: The resource was not found (404).

Example:

```swift
do {
    let todos: [Todo] = try await api.getData(endpoint: "/todos")
} catch ApiError.notFound {
    print("Resource not found")
} catch {
    print("An unexpected error occurred:", error)
}
```
