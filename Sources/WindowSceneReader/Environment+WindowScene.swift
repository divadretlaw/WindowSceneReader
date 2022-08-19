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
    @ViewBuilder public func setWindowScene(_ windowScene: UIWindowScene? = nil) -> some View {
        if let windowScene = windowScene {
            environment(\.windowScene, windowScene)
        } else {
            modifier(CaptureWindowScene())
        }
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
