//
//  TabViewController.swift
//  LiquidGlass
//
//  Created by 김윤석 on 7/5/25.
//

import UIKit

final class TabViewController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)

        let vc2 = LiquidGlassButtonViewController()
        vc2.tabBarItem = UITabBarItem(title: "Button", image: UIImage(systemName: "circle.grid.2x2"), tag: 1)

        let vc3 = UIViewController()
        vc3.view.backgroundColor = .systemTeal
        vc3.tabBarItem = UITabBarItem(title: "Third", image: UIImage(systemName: "gear"), tag: 2)
        
        self.viewControllers = [vc2, vc3]
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
