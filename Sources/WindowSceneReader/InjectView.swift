//
//  InjectView.swift
//  WindowSceneReader
//
//  Created by David Walter on 12.08.22.
//

import UIKit

class WindowInjectView: InjectView {
    var onUpdate: (UIWindow) -> Void
    
    init(onUpdate: @escaping (UIWindow) -> Void) {
        self.onUpdate = onUpdate
        super.init()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        if let window = self.window {
            onUpdate(window)
        }
    }
}

class InjectView: UIView {
    init() {
        super.init(frame: .zero)
        isHidden = true
        isUserInteractionEnabled = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
