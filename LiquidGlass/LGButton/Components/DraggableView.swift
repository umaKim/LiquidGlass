//
//  DraggableView.swift
//  LiquidGlass
//
//  Created by 김윤석 on 7/7/25.
//

import UIKit

class DraggableView: UIVisualEffectView {
    private var panGesture: UIPanGestureRecognizer!
    
    init(frame: CGRect, effect: UIGlassEffect = UIGlassEffect()) {
        let effect = effect
        effect.isInteractive = true
        super.init(effect: effect)
        self.frame = frame
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
//        layer.cornerRadius = 16
        clipsToBounds = true
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.addGestureRecognizer(panGesture)
        isUserInteractionEnabled = true
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        switch gesture.state {
        case .changed, .ended:
            center = CGPoint(x: center.x + translation.x, y: center.y + translation.y)
            gesture.setTranslation(.zero, in: self.superview)
        default:
            break
        }
    }
}
