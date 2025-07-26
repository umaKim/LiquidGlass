//
//  GlassContainerEffectDemoViewController.swift
//  LiquidGlass
//
//  Created by 김윤석 on 7/6/25.
//

import UIKit

final class LiquidGlassContentView: UIVisualEffectView {
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
//        contentView.addSubViews(cv, label1)
//        contentView.addSubViews(draggable, draggable2, translatesAutoresizingMaskIntoConstraints: true)
        contentView.addSubViews(label1, draggable3, draggable4)

        NSLayoutConstraint.activate([
            label1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label1.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            draggable3.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            draggable3.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            draggable3.widthAnchor.constraint(equalToConstant: 100),
            draggable3.heightAnchor.constraint(equalToConstant: 100),
            
            draggable4.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            draggable4.topAnchor.constraint(equalTo: draggable3.bottomAnchor, constant: 10),
            draggable4.widthAnchor.constraint(equalToConstant: 100),
            draggable4.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private let draggable = DraggableView(frame: CGRect(x: 100, y: 200, width: 150, height: 150))
    
    private let draggable2 = DraggableView(frame: CGRect(x: 200, y: 200, width: 150, height: 150))
    
    private let draggable3 = DraggableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    private let draggable4 = DraggableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    
    private let label1: LiquidGlassLabel = {
        let lb = LiquidGlassLabel()
        lb.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lb.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return lb
    }()
    
    private let cv: LiquidGlassCollectionView = {
        let cv = LiquidGlassCollectionView()
        return cv
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class GlassContainerEffectDemoViewController: UIViewController {
    private let contentView: LiquidGlassContentView = {
        let effect = UIGlassContainerEffect()
        effect.spacing = 100
        let contentView = LiquidGlassContentView(effect: effect)
        return contentView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
        
        view.addSubview(imageView)
        imageView.frame = view.bounds
        
        view.addSubViews(contentView)
        contentView.constraintAll(to: view)
    }
    
    private let imageView = UIImageView(image: UIImage(named: "Thelastcalling"))
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
