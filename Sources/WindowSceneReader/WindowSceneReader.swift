//
//  WindowSceneReader.swift
//  WindowSceneReader
//
//  Created by David Walter on 12.08.22.
//

import SwiftUI
import UIKit

/// A container view that reads the current window scene
///
/// This view reads the current window scene and makes the window scene
/// available in the `Envionment`
public struct WindowSceneReader<Content>: View where Content: View {
    @ViewBuilder var content: (UIWindowScene) -> Content
    
    @State private var windowScene: UIWindowScene?
    
    public var body: some View {
        if let windowScene = windowScene {
            content(windowScene)
        } else {
            Color.clear
                .readWindow {
                    self.windowScene = $0.windowScene
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

#if DEBUG
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

struct Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
