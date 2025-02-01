//
//  Environment+WindowScene.swift
//  WindowSceneReader
//
//  Created by David Walter on 12.08.22.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import SwiftUI

private struct WindowSceneKey: EnvironmentKey {
    static var defaultValue: UIWindowScene? {
        MainActor.runSync {
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .first
        }
    }
}

public extension EnvironmentValues {
    /// The window scene of this environment.
    ///
    /// Read this environment value from within a view to find the window scene
    /// for this presentation. If no `UIWindowScene` was set then it will default
    /// to the first connected `UIWindowScene`
    var windowScene: UIWindowScene? {
        get { self[WindowSceneKey.self] }
        set { self[WindowSceneKey.self] = newValue }
    }
}

public extension View {
    /// Sets the window scene for this presentation. If no window scene is provided,
    /// the current windows scene will be determined using ``captureWindowScene(perform:)``
    ///
    /// - Parameter windowScene: The `UIWindowScene` to use for this presentation
    ///
    /// - Returns: A view where the given or captured windows scene is available for child views
    @ViewBuilder func withWindowScene(_ windowScene: UIWindowScene? = nil) -> some View {
        if let windowScene {
            environment(\.windowScene, windowScene)
        } else {
            modifier(CaptureWindowScene())
        }
    }
    
    /// Capture the current window scene of the view and make it available for child views
    ///
    /// - Parameter action: The action to perform when the `UIWindowScene` is found.
    ///
    /// - Returns: A view where the current window scene is available for child views
    func captureWindowScene(perform action: ((UIWindowScene) -> Void)? = nil) -> some View {
        modifier(CaptureWindowScene(action: action))
    }
}

private struct CaptureWindowScene: ViewModifier {
    var action: ((UIWindowScene) -> Void)?
    
    @State private var windowScene: UIWindowScene?

    func body(content: Content) -> some View {
        content
            .onWindowChange(initial: true) { window in
                windowScene = window.windowScene
                if let windowScene = window.windowScene {
                    action?(windowScene)
                }
            }
            .environment(\.windowScene, windowScene)
    }
}
#endif
