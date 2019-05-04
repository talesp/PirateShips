//
//  ShipListViewModel.swift
//  PirateShips
//
//  Created by Tales Pinheiro De Andrade on 04/05/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import UIKit

class ShipListViewModel {
    private var collectionView: UICollectionView

    private let dataSource: ShipListViewDataSource

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()

        let space: CGFloat = 8
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)

        let screenWidth = UIScreen.main.bounds.width
        let columns: CGFloat
        if collectionView.traitCollection.horizontalSizeClass == .compact {
            columns = 2
        }
        else {
            columns = 3
        }
        let width = (screenWidth - (columns - 1) * space - (layout.sectionInset.left + layout.sectionInset.right)) / columns
        layout.estimatedItemSize = CGSize(width: width, height: 50)
        return layout
    }()

    var viewState: ViewState<[Ship]> = .loading {
        didSet {
            switch viewState {
            case .loading:
                collectionView.backgroundView?.backgroundColor = .gray
            case let .content(shipList):
                dataSource.shipList = shipList
            case .error:
                collectionView.backgroundView?.backgroundColor = .black
            }
        }
    }

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        dataSource = ShipListViewDataSource(collectionView: self.collectionView)
        collectionView.dataSource = dataSource
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
}
