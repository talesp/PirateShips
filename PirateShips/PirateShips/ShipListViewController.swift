//
//  ShipListViewController.swift
//  PirateShips
//
//  Created by tales.andrade on 25/04/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import UIKit

class ShipListViewDataSource: NSObject, UICollectionViewDataSource {

    var shipList: [Ship] = [] {
        didSet {
            DispatchQueue.main.async { [unowned self] in
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
        let cell: ShipListCell =  collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(ship: ship)
        return cell
    }

}

class ShipListViewController: UIViewController {

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()

        let space: CGFloat = 8
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)

        let screenWidth = UIScreen.main.bounds.width
        let columns: CGFloat
        if self.traitCollection.horizontalSizeClass == .compact {
            columns = 2
        }
        else {
            columns = 3
        }
        let width = (screenWidth - (columns - 1) * space - (layout.sectionInset.left + layout.sectionInset.right)) / columns
        layout.estimatedItemSize = CGSize(width: width, height: 100)
        return layout
    }()

    private(set) lazy var collectionView = UICollectionView(frame: .zero,
                                                            collectionViewLayout: self.layout)

    private(set) lazy var datasource: ShipListViewDataSource = ShipListViewDataSource(collectionView: collectionView)

    override func loadView() {
        self.view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = datasource
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 8)
        super.traitCollectionDidChange(previousTraitCollection)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 8)
        layout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }

}
