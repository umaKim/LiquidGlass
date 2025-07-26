//
//  CollectionViewController.swift
//  LiquidGlass
//
//  Created by 김윤석 on 7/5/25.
//

// custom Liquid Glass 구현 방법 정리
// 1. Effect를 정의 ex) UIGlassContainerEffect(), UIGlassEffect()
// 2. 그 Effect를 담을수 있는 View 정의 ex) UIVisualEffectView(), UIButton(configuration: UIButton.Configuration.glass())
// 3. 어떤 LG효과를 낼지에 따라서 위의 사용이 달라진다.
//      - LG의 대표적인 효과: 1. 가까이에 있으면 Liquid 처럼 서로합쳐짐
//                        2. 건드리면 "쁑"하면서 흔들리는 효과
//                        3. 등등
// 3-1.을 하고 싶다면 2개 이상의 LG view(2.에서 보여진)들을 담고 있는 Super LG View가 필요하다.

import UIKit

// MARK: - ContentView (custom content inside the glass effect)
final class ContentView: UIVisualEffectView {
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Dion과 우마 커플 통장"
        lb.font = .systemFont(ofSize: 18, weight: .bold)
        lb.textColor = .label
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var currentBalance: LiquidGlassLabel = {
        let lb = LiquidGlassLabel()
//        lb.text = "17원"
//        lb.font = .systemFont(ofSize: 16, weight: .medium)
//        lb.textColor = .label
        lb.backgroundColor = .red
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var transferButton: UIButton = {
        var config = UIButton.Configuration.glass()
        config.title = "glass"
//        let effect = UIGlassContainerEffect()
//        config.background.visualEffect = effect
        let bt = UIButton(configuration: config)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(didTapTransferButton), for: .touchUpInside)
        bt.setTitleColor(.label, for: .normal)
        return bt
    }()
    
    @objc
    private func didTapTransferButton() {
        print("Tap")
    }
    
    private lazy var transferButton2: UIButton = {
        var config = UIButton.Configuration.prominentGlass()
        config.title = "prominent glass"
        config.baseBackgroundColor = .systemYellow
//        let effect = UIGlassContainerEffect()
//        config.background.visualEffect = effect
        let bt = UIButton(configuration: config)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(didTapTransferButton2), for: .touchUpInside)
        bt.setTitleColor(.label, for: .normal)
        return bt
    }()
    
    @objc
    private func didTapTransferButton2() {
        print("Tap2")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
          print("Hit test: \(view.debugDescription)")
          return view
    }
    
    init() {
        let containerEffect = UIGlassContainerEffect()
        containerEffect.spacing = 20
        super.init(effect: containerEffect)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let leftTopSv = UIStackView(arrangedSubviews: [titleLabel, currentBalance])
        leftTopSv.axis = .vertical
        leftTopSv.alignment = .leading
        leftTopSv.spacing = 4
        
        let totalSv = UIStackView(arrangedSubviews: [leftTopSv, transferButton, transferButton2])
        totalSv.axis = .vertical
        totalSv.alignment = .fill
        totalSv.spacing = 12
        
        contentView.addSubViews(totalSv)
        totalSv.constraintAll(to: self.contentView, horizontalPadding: 16, verticalPadding: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - GlassCollectionViewCell
final class GlassCollectionViewCell: UICollectionViewCell {
    static let id = "GlassCollectionViewCell"

    private let glassEffectView: UIVisualEffectView = {
        let glassEffect = UIGlassEffect()
//        UIGlassEffect()
        glassEffect.tintColor = .systemYellow.withAlphaComponent(0.2)
        glassEffect.isInteractive = true
//        glassEffect.isInteractive = true // enables press ripple animation
        let vev = UIVisualEffectView(effect: glassEffect)
//        vev.layer.cornerRadius = 20
        vev.layer.masksToBounds = true
        vev.isUserInteractionEnabled = true
//        vev.backgroundColor = .systemRed
        return vev
    }()
    
    private let customView = ContentView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        applyLiquidGlass()
//        normalApply()
//        backgroundColor = .clear
    }
    
    private func applyLiquidGlass() {
        contentView.addSubViews(glassEffectView)
        glassEffectView.contentView.addSubview(customView)

        glassEffectView.constraintAll(to: self)
        customView.constraintAll(to: glassEffectView)
        
//        glassEffectView.effect = glassContainerEffect
    }
    
    private func normalApply() {
        addSubViews(customView)
//        customView.backgroundColor = .red
        customView.constraintAll(to: self)
    }

    func configure(with text: String) {
        // If you want to dynamically set titleLabel text, add a method in ContentView
        // e.g., customView.titleLabel.text = text
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CollectionViewController
final class CollectionViewController: UICollectionViewController {

    private let items = (1...20).map { "Item \($0)" }

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16

        super.init(collectionViewLayout: layout)

        collectionView.backgroundView = UIImageView(image: UIImage(named: "Thelastcalling"))
        collectionView.backgroundView?.contentMode = .scaleAspectFill
        collectionView.backgroundColor = .systemBackground
        collectionView.register(GlassCollectionViewCell.self, forCellWithReuseIdentifier: GlassCollectionViewCell.id)
        
        navigationItem.rightBarButtonItems = [.init(title: "이미지", image: nil, target: self, action: #selector(imageToggle))]
    }
    
    @objc private func imageToggle() {
        if collectionView.backgroundView == nil {
            collectionView.backgroundView = UIImageView(image: UIImage(named: "Thelastcalling"))
            collectionView.backgroundView?.contentMode = .scaleAspectFill
        } else {
            collectionView.backgroundView = nil
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Data Source
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlassCollectionViewCell.id, for: indexPath) as? GlassCollectionViewCell else {
            fatalError("Could not dequeue GlassCollectionViewCell")
        }
        let item = items[indexPath.item]
        cell.configure(with: item)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 16
        let width = collectionView.bounds.width - (spacing * 2)
        return CGSize(width: width, height: width * 0.5)
    }
}

// MARK: - UIView extension for constraints
extension UIView {
    func constraintAll(to view: UIView) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func constraintAll(to view: UIView, horizontalPadding: CGFloat, verticalPadding: CGFloat) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalPadding),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: horizontalPadding * -1),
            topAnchor.constraint(equalTo: view.topAnchor, constant: verticalPadding),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: verticalPadding * -1)
        ])
    }
}
