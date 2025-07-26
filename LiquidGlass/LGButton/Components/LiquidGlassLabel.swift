//
//  LiquidGlassLabel.swift
//  LiquidGlass
//
//  Created by 김윤석 on 7/6/25.
//

import UIKit

class LiquidGlassLabel: UIVisualEffectView {
    private let label: UILabel = {
        let lb = UILabel()
        lb.text = "Liquid"
        lb.textAlignment = .center
        return lb
    }()
    
    init() {
        let effect = UIGlassEffect()
        effect.isInteractive = true
        super.init(effect: effect)
        
        contentView.addSubViews(label)
        label.constraintAll(to: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
