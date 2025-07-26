//
//  LiquidGlassButtonViewController.swift
//  LiquidGlass
//
//  Created by 김윤석 on 7/5/25.
//

import SwiftUI

import UIKit

final class LiquidGlassButtonContainerView: UIVisualEffectView {
    init(_ effect: UIGlassContainerEffect = UIGlassContainerEffect()) {
        effect.spacing = 50
        super.init(effect: effect)
       
    }
    
    func setContent(content: () -> UIView) {
        contentView.addSubview(content())
        let view = content()
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class LiquidGlassButtonViewController: UIViewController {
    let bt: UIButton =  {
        var config = UIButton.Configuration.glass()
        config.title = "Awesome"
        let bt = UIButton(configuration: config)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    let bt2: UIButton =  {
        var config = UIButton.Configuration.prominentGlass()
        config.title = "Awesome2"
        let bt = UIButton(configuration: config)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    let bt3: UIButton =  {
        var config = UIButton.Configuration.prominentGlass()
        config.title = "Awesome"
        config.cornerStyle = .fixed
        let bt = UIButton(configuration: config)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    let bt24: UIButton =  {
        var config = UIButton.Configuration.prominentGlass()
        config.title = "Awesome2"
        let bt = UIButton(configuration: config)
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }()
    
    let segment: UISegmentedControl = {
        let items: [String] = ["A", "B"]
        let sg = UISegmentedControl(items: items)
        sg.selectedSegmentIndex = 0
        return sg
    }()
    
    let glassView = LiquidGlassButtonContainerView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let buttons = [
            bt,
            bt2,
            segment
        ]
        
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .vertical
        sv.spacing = 20
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(sv)

        NSLayoutConstraint.activate([
            sv.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sv.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        buttons.forEach { bt in
            bt.heightAnchor.constraint(equalToConstant: 50).isActive = true
            bt.widthAnchor.constraint(equalToConstant: 150).isActive = true
        }
        
        let sv2 = UIStackView(arrangedSubviews: [bt3, bt24])
        sv2.axis = .horizontal
        sv2.spacing = 20
        sv2.alignment = .center
        
        glassView.setContent {
            sv2
        }
        glassView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(glassView)
        
        NSLayoutConstraint.activate([
            glassView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            glassView.topAnchor.constraint(equalTo: sv.bottomAnchor, constant: 100)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//
//merge conflict 전
//func 통장만들기(isMiniJunior: Bool)
//
//통장만들기(isMiniJunior: false)
//
//====================
//
//merge conflict 후
//enum Types {
//    case `default`
//    case isMiniJunior(Bool)
//    case 개사통
//}
//
//func 통장만들기(type: Types)
//
//통장만들기(type: .isMiniJunior(false))
