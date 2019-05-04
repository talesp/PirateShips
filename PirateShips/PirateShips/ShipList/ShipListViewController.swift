//
//  ShipListViewController.swift
//  PirateShips
//
//  Created by tales.andrade on 25/04/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import UIKit

class ShipListViewController: UIViewController {
    private(set) lazy var viewModel = ShipListViewModel(collectionView: collectionView)

    private(set) lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func loadView() {
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Pirate Ships"
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 8)
        collectionView.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
}
