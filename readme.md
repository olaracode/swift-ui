# Navigation

For this project we created a simple navigation stack using `NavigationStack` alongside with `NavigationPath`

![A video of the navigation demo](./docs/navigation-demo.gif)

## Setting up the navigation

```swift
// Creating a path state allows us to push navigation on top of navigation
// Without it we can't really stack views on top of views indefinetely
@State private var path = NavigationPath()
var body: some View {
    NavigationStack(path: $path){
        // Elements ....
    }
     // Sets the title on top
    .navigationTitle("Gaming")
    // navigationDestination is used basically as a switch case
    // we create one navigationDestination for each of the data types
    // we can navigate to
    .navigationDestination(for: Platform.self){ platform in
        PlatformView(platform: platform, games: games)
    }
    .navigationDestination(for: Game.self){ game in
            GameView(game:game, platforms: platforms)
    }
}
```
