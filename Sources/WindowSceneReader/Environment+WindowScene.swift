//
//  Environment+WindowScene.swift
//  WindowSceneReader
//
//  Created by David Walter on 12.08.22.
//

import SwiftUI

struct WindowSceneKey: EnvironmentKey {
    static var defaultValue: UIWindowScene? {
        UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.first
    }
}

extension EnvironmentValues {
    /// The window scene of this environment.
    ///
    /// Read this environment value from within a view to find the window scene
    /// for this presentation. If no `UIWindowScene` was set then it will default
    /// to the first connected `UIWindowScene`
    public var windowScene: UIWindowScene? {
        get {
            self[WindowSceneKey.self]
        }
        set {
            self[WindowSceneKey.self] = newValue
        }
    }
}

extension View {
    /// Sets the window scene for this presentation. If no window scene is provided,
    /// the current windows scene will be determined
    ///
    /// - Parameter windowScene: The `UIWindowScene` to use for this presentation
    @available(*, deprecated, renamed: "windowScene")
    @ViewBuilder public func setWindowScene(_ windowScene: UIWindowScene? = nil) -> some View {
        self.windowScene(windowScene)
    }
    
    /// Sets the window scene for this presentation. If no window scene is provided,
    /// the current windows scene will be determined using `View.captureWindowScene`
    ///
    /// - Parameter windowScene: The `UIWindowScene` to use for this presentation
    ///
    /// - Returns: A view where the given or captured windows scene is available for child views
    @ViewBuilder public func windowScene(_ windowScene: UIWindowScene? = nil) -> some View {
        if let windowScene = windowScene {
            environment(\.windowScene, windowScene)
        } else {
            modifier(CaptureWindowScene())
        }
    }
    
    /// Capture the current window scene of the view and make it available for child views
    ///
    /// - Returns: A view where the current windows scene is available for child views
    public func captureWindowScene() -> some View {
        modifier(CaptureWindowScene())
    }
}

struct CaptureWindowScene: ViewModifier {
    @State var windowScene: UIWindowScene?
    
    func body(content: Content) -> some View {
        content
            .readWindow {
                self.windowScene = $0.windowScene
            }
            .environment(\.windowScene, windowScene)
    }
}
