# Cars War Game

In this project I built a simple Cards game using Swift UI, it deals a random card, whichever has the higher card wins a point

**Index**

- [State](#state)
- [UI](#ui)
- [General Syntax](#syntax)

![Preview Image](./preview.png);

## State

To handle dynamic data we need to use the attribute wrapper `@State`

```swift
struct ContentView: View {
    @State var playerCard = "card7"
    // ...
}
```

By declaring a state variable we can modify the value on any function we want to by doing simple assignation

```swift
func deal(){
    playerCard = // ...
}
```

## UI

**Button with image**: To create a button with something different than a text we need to use the syntax `Button(action:, label:)`,

```swift
Button {
    // action
} label: {
    // Element | View to display
}
```

On our case we used the button with an image

```swift
Button {
    deal()
} label: {
    Image("button")
}
```

## Syntax

Some general Swift syntax I learned are [function declaration](#function), [conditionals](#conditional)

### Function

```swift
func someFunction(){
    // basic function declaration
}

// function with arguments
func add(number1: Int, number2: Int) {
    print(number1 + number2)
}

// function with arguments and return type
func sayHello(name: String) -> String {
    return "Hello \(name)"
}
```

### Conditional

```swift
if condition {
    // Case 1
}
else if secondCondition {
    // Case 2
} else {
    // Default Case
}
```
