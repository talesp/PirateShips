//
//  ShipListCell.swift
//  PirateShips
//
//  Created by Tales Pinheiro De Andrade on 27/04/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import UIKit

class ShipListCell: UICollectionViewCell, Reusable, ViewConfiguration {

    private lazy var shipHeaderView: ShipHeaderView = {
        let view = ShipHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViewConfiguration()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(ship: Ship) {
        shipHeaderView.priceLabel.text = "$ \(ship.price)"
        shipHeaderView.titleLabel.text = ship.title
        guard let url = URL(string: ship.image) else { return }
        guard self.shipHeaderView.imageView.image == nil else { return }
        URLSession.shared.dataTask(with: url) { [unowned self] data, response, error in
            guard let data = data else { return }

            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.shipHeaderView.imageView.image = image
                guard let collectionView = self.superview as? UICollectionView else { return }
                collectionView.collectionViewLayout.invalidateLayout()
            }
        }.resume()
    }

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes)
        -> UICollectionViewLayoutAttributes {

            guard let collectionView = self.superview as? UICollectionView,
                let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return layoutAttributes }
            let sectionInset = layout.sectionInset
            let columns: CGFloat
            if self.traitCollection.horizontalSizeClass == .compact {
                columns = 2
            }
            else {
                columns = 3
            }
            let space: CGFloat = 8.0
            let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
                - sectionInset.left
                - sectionInset.right
                - collectionView.contentInset.left
                - collectionView.contentInset.right
                - (columns - 1) * space

            let referenceSize = CGSize(width: referenceWidth/columns, height: collectionView.bounds.size.height)
            let size = contentView.systemLayoutSizeFitting(referenceSize, withHorizontalFittingPriority: UILayoutPriority.defaultHigh, verticalFittingPriority: UILayoutPriority.fittingSizeLevel)

            layoutAttributes.size = size

            return layoutAttributes
    }
}

extension ShipListCell {
    func buildViewHierarchy() {
        self.contentView.addSubview(shipHeaderView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            shipHeaderView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            shipHeaderView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            shipHeaderView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            shipHeaderView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
            ])
    }

}
