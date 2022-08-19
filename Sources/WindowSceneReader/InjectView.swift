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
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        if let window = newWindow {
            onUpdate(window)
        } else {
            // In case there was no window yet, we try again slightly delayed
            // This should never happen but is there just in case
            DispatchQueue.main.async { [weak self] in
                if let window = self?.window {
                    self?.onUpdate(window)
                }
            }
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
