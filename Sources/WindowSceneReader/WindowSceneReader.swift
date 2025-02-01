//
//  WindowSceneReader.swift
//  WindowSceneReader
//
//  Created by David Walter on 12.08.22.
//

import SwiftUI
import WindowReader
#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

/// A container view that reads the current window scene
///
/// This view reads the current window scene and makes the window scene
/// available in the `Envionment`
public struct WindowSceneReader<Content>: View where Content: View {
    public var content: (UIWindowScene) -> Content
    
    public var body: some View {
        WindowReader { window in
            if let windowScene = window.windowScene {
                content(windowScene)
                    .environment(\.windowScene, windowScene)
            }
        }
    }
    
    /// Creates an instance that can reads the current window scene
    ///
    /// - Parameter content: The reader's content where the window scene is accessible
    public init(@ViewBuilder content: @escaping (UIWindowScene) -> Content) {
        self.content = content
    }
}

#Preview {
    WindowSceneReader { windowScene in
        VStack {
            VStack(alignment: .leading) {
                Text("WindowScene")
                    .foregroundColor(.primary)
                Text(windowScene.debugDescription)
                    .foregroundColor(.secondary)
            }
            .multilineTextAlignment(.leading)
        }
        .padding()
    }
}
#endif
