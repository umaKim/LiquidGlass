//
//  ViewController.swift
//  LiquidGlass
//
//  Created by 김윤석 on 7/5/25.
//

import UIKit

class ViewController: UIViewController {
    
    private let backgroundImage: UIImageView = .init(image: .init(named: "Thelastcalling"))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        let containerEffect = UIGlassContainerEffect()
//        let containerEffectView = UIVisualEffectView(effect: containerEffect)
//        
//        let glassEffect = UIGlassEffect()
//        let view1 = UIVisualEffectView(effect: glassEffect)
//        view1.backgroundColor = .red
//        let view2 = UIVisualEffectView(effect: glassEffect)
//        view2.backgroundColor = .blue
//        
//        containerEffectView.contentView.addSubview(view1)
//        containerEffectView.contentView.addSubview(view2)
//        
//        view1.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            view1.leadingAnchor.constraint(equalTo: containerEffectView.leadingAnchor),
//            view1.topAnchor.constraint(equalTo: containerEffectView.topAnchor),
//            view1.widthAnchor.constraint(equalToConstant: 100),
//            view1.heightAnchor.constraint(equalToConstant: 100)
//        ])
//        
//        let glassContainerEffect = UIGlassContainerEffect()
//        glassContainerEffect.spacing = 20
//        containerEffectView.effect = glassContainerEffect
//        
//        self.view.addSubview(containerEffectView)
//        containerEffectView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            containerEffectView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            containerEffectView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            containerEffectView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            containerEffectView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
//        ])
        
        view.addSubview(backgroundImage)
        backgroundImage.frame = view.bounds
        
        var config = UIButton.Configuration.glass()
        config.title = "AW"
        let button = UIButton(configuration: config)
        view.addSubViews(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let glassEffect = UIGlassEffect()
        let effectiveView = UIVisualEffectView(effect: glassEffect)
        view.addSubViews(effectiveView)
        NSLayoutConstraint.activate([
            effectiveView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 30),
            effectiveView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            effectiveView.widthAnchor.constraint(equalToConstant: 300),
            effectiveView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension UIView {
    func addSubViews(_ views: UIView..., translatesAutoresizingMaskIntoConstraints: Bool = false) {
        views.forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
        }
    }
}
