//
//  ShipListViewDataSource.swift
//  PirateShips
//
//  Created by Tales Pinheiro De Andrade on 04/05/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import UIKit

class ShipListViewDataSource: NSObject, UICollectionViewDataSource {
    var shipList: [Ship] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.collectionView?.reloadData()
            }
        }
    }

    private weak var collectionView: UICollectionView?

    init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        self.collectionView?.registerCell(cellType: ShipListCell.self)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shipList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ship = shipList[indexPath.item]
        let cell: ShipListCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(ship: ship)
        return cell
    }
}
