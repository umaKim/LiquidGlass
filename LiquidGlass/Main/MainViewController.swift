//
//  MainViewController.swift
//  LiquidGlass
//
//  Created by 김윤석 on 7/5/25.
//

import Foundation
import UIKit

final class MainViewController: UITableViewController {

    // Example data source
    private let items = [
        "Buttons",
        "Tab",
        "Customs",
        "EffectContainer"
    ]

    init() {
        super.init(nibName: nil, bundle: nil)
        tableView.register(MainViewControllerCell.self, forCellReuseIdentifier: MainViewControllerCell.id)
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = .systemBackground
        title = "LiquidGlass Test"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewControllerCell.id, for: indexPath) as! MainViewControllerCell
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = items[indexPath.row]
        
        if selectedItem == "Buttons" {
            let buttonVc = LiquidGlassButtonViewController()
            navigationController?.pushViewController(buttonVc, animated: true)
        } else if selectedItem == "Tab" {
            let vc = TabViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if selectedItem == "Customs" {
            let vc = CollectionViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if selectedItem == "EffectContainer" {
            let vc = GlassContainerEffectDemoViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
