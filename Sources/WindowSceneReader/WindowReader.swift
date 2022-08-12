//
//  WindowReader.swift
//  WindowSceneReader
//
//  Created by David Walter on 12.08.22.
//

import SwiftUI

extension View {
    public func readWindow(onUpdate: @escaping (UIWindow) -> Void) -> some View {
        overlay(WindowReader(onUpdate: onUpdate))
    }
}

struct WindowReader: UIViewRepresentable {
    var onUpdate: (UIWindow) -> Void
    
    func makeUIView(context: Context) -> WindowInjectView {
        WindowInjectView(onUpdate: onUpdate)
    }
    
    func updateUIView(_ uiView: WindowInjectView, context: Context) {
        
    }
}
