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
        layout.estimatedItemSize = CGSize(width: width, height: 50)
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
        view.backgroundColor = .white
        collectionView.dataSource = datasource
        collectionView.delegate = self
        self.title = "Pirate Ships"
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

extension ShipListViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let space: CGFloat = 8

        let columns: CGFloat
        if self.traitCollection.horizontalSizeClass == .compact {
            columns = 2
        }
        else {
            columns = 3
        }

        let collectionViewWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
        let contentInset: CGFloat = collectionView.contentInset.left + collectionView.contentInset.right
        let sectionInset: CGFloat = layout.sectionInset.left + layout.sectionInset.right
        let width = (collectionViewWidth - contentInset - sectionInset - (columns - 1) * space) / columns
        let size: CGSize = CGSize(width: width, height: 50)
        let cell: ShipListCell = collectionView.dequeueReusableCell(for: indexPath)
        let adjustedSize: CGSize = cell.contentView.systemLayoutSizeFitting(size, withHorizontalFittingPriority: .required, verticalFittingPriority: UILayoutPriority(rawValue: 500))
        return adjustedSize
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let datasource = collectionView.dataSource as? ShipListViewDataSource else { return }
        let ship = datasource.shipList[indexPath.item]
        let detailViewController = ShipDetailViewController()
        detailViewController.setup(title: ship.title ?? "",
                                   price: ship.price,
                                   description: ship.description,
                                   image: ship.image,
                                   greeting: ship.greeting)
        self.show(detailViewController, sender: self)
    }
}
