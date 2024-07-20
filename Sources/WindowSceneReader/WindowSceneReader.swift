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
    
    @State private var windowScene: UIWindowScene?
    
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
    @inlinable public init(@ViewBuilder content: @escaping (UIWindowScene) -> Content) {
        self.content = content
    }
}

struct Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
    struct ContentView: View {
        var body: some View {
            NavigationView {
                List {
                    NavigationLink {
                        DetailView()
                    } label: {
                        Text("Detail")
                    }
                    
                    Button {
                    } label: {
                        Text("Some Button")
                    }
                }
                .navigationBarTitle("Demo")
            }
        }
    }
    
    struct DetailView: View {
        @Environment(\.windowScene) private var windowScene
        
        var body: some View {
            WindowSceneReader { _ in
                List {
                    Button {
                    } label: {
                        Text("Some Button")
                    }
                }
            }
            .navigationBarTitle("Detail View")
        }
    }
}
#endif
