# WindowSceneReader

Access the current `UIWindowScene` from SwiftUI

## Usage

### SwiftUI Lifecycle

Read the current `UIWindowScene` with `WindowSceneReader`

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            WindowSceneReader { windowScene in
                ContentView()
            }
        }
    }
}
```

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .setWindowScene()
        }
    }
}
```

On child views the `UIWindowScene` will be available in the `Environment`

### UIKit Lifecycle

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let rootView = ContentView()
                .environment(\.windowScene, windowScene)
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: rootView)
            self.window = window
            window.makeKeyAndVisible()
    }
}
```

## Environment

```swift
@Environment(\.windowScene) var windowScene
```

The `@Environment(\.windowScene) var windowScene` defaults to the first connected `UIWindowScene` or `nil` if no `UIWindowScene` is connected.

## License

See [LICENSE](LICENSE)
