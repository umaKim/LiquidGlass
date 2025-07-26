//
//  LiquidGlassCollectionView.swift
//  LiquidGlass
//
//  Created by 김윤석 on 7/6/25.
//

import UIKit

final class LiquidGlassCollectionView: UIVisualEffectView {
    init() {
        let effect = UIGlassEffect()
        effect.isInteractive = true
        super.init(effect: effect)
        
        contentView.addSubViews(cv)
        cv.constraintAll(to: self.contentView)
        backgroundColor = .clear
        
        tintColor = .clear
    }
    
    private lazy var cv: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(GlassCollectionViewCell.self, forCellWithReuseIdentifier: GlassCollectionViewCell.id)
        cv.dataSource = self
        cv.delegate = self
        cv.contentInset = .init(top: 100, left: 0, bottom: 0, right: 0)
        cv.backgroundColor = .clear
        return cv
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let items = (1...20).map { "Item \($0)" }
}

extension LiquidGlassCollectionView: UICollectionViewDataSource {
    // MARK: - Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GlassCollectionViewCell.id, for: indexPath) as? GlassCollectionViewCell else {
            fatalError("Could not dequeue GlassCollectionViewCell")
        }
        let item = items[indexPath.item]
        cell.configure(with: item)
        cell.backgroundColor = .red
        return cell
    }
}

extension LiquidGlassCollectionView: UICollectionViewDelegate {
    
}

extension LiquidGlassCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 16
        let width = collectionView.bounds.width - (spacing * 2)
        return CGSize(width: width, height: width * 0.5)
    }
}
