//
//  WindowSceneReader.swift
//  WindowSceneReader
//
//  Created by David Walter on 12.08.22.
//

import SwiftUI
import UIKit

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
    
    public init(@ViewBuilder content: @escaping (UIWindowScene) -> Content) {
        self.content = content
    }
}

#if DEBUG
struct ContentView: View {
    @State private var isPresented = true
    
    var body: some View {
        NavigationView {
            WindowSceneReader { _ in
                List {
                    NavigationLink {
                        DetailView()
                    } label: {
                        Text("Detail")
                    }
                    
                    Button {
                        isPresented = true
                    } label: {
                        Text("Show")
                    }
                }
                .navigationBarTitle("Custom Alert")
            }
        }
    }
}

struct DetailView: View {
    @State private var isPresented = false
    
    var body: some View {
        List {
            Button {
                isPresented = true
            } label: {
                Text("Show")
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
