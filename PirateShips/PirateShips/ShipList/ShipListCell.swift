//
//  ShipListCell.swift
//  PirateShips
//
//  Created by Tales Pinheiro De Andrade on 27/04/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import UIKit
import Kingfisher

class ShipListCell: UICollectionViewCell, Reusable, ViewConfiguration {

    private lazy var shipHeaderView: ShipHeaderView = {
        let view = ShipHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViewConfiguration()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(ship: Ship) {
        shipHeaderView.priceLabel.text = "$ \(ship.price)"
        shipHeaderView.titleLabel.text = ship.title
        guard let url = URL(string: ship.image) else { return }
        self.shipHeaderView.imageView.kf.setImage(with: url)
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
        -> UICollectionViewLayoutAttributes {
            let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
            guard let collectionView = self.superview as? UICollectionView,
                let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return layoutAttributes }
            let columns: CGFloat
            if self.traitCollection.horizontalSizeClass == .compact {
                columns = 2
            }
            else {
                columns = 3
            }
            let space: CGFloat = 8.0
            let collectionViewWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            let contentInset: CGFloat = collectionView.contentInset.left + collectionView.contentInset.right
            let sectionInset: CGFloat = layout.sectionInset.left + layout.sectionInset.right
            let width = (collectionViewWidth - contentInset - sectionInset - (columns - 1) * space) / columns
            let referenceSize = CGSize(width: width, height: 50)
            let size = contentView.systemLayoutSizeFitting(referenceSize, withHorizontalFittingPriority: .required, verticalFittingPriority: UILayoutPriority(rawValue: 500))

            layoutAttributes.size = size

            return layoutAttributes
    }
}

extension ShipListCell {
    func buildViewHierarchy() {
        contentView.addSubview(shipHeaderView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            shipHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shipHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shipHeaderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            shipHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }

    func configureViews() {
        contentView.layer.cornerRadius = 4.0
        contentView.layer.masksToBounds = true
        
    }
}
