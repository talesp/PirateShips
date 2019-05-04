//
//  ShipCoordinator.swift
//  PirateShips
//
//  Created by Tales Pinheiro De Andrade on 04/05/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import UIKit

class ShipCoordinator: NSObject {
    private weak var rootViewController: UINavigationController?
    private let webservice: Webservice

    init(rootViewController: UINavigationController, webservice: Webservice = Webservice()) {
        self.rootViewController = rootViewController
        self.webservice = webservice
    }

    func start() {
        let viewController = ShipListViewController(nibName: nil, bundle: nil)
        viewController.collectionView.delegate = self
        rootViewController?.pushViewController(viewController, animated: false)

        webservice.load(PirateData.resource) { result in
            switch result {
            case let .success(shipData):
                DispatchQueue.main.async {
                    viewController.viewModel.viewState = .content(shipData.ships.compactMap { $0 })
                }
            case let .failure(error):
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                viewController.show(alertController, sender: self)
            }
        }
    }
}

extension ShipCoordinator: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = 8

        let columns: CGFloat
        if collectionView.traitCollection.horizontalSizeClass == .compact {
            columns = 2
        }
        else {
            columns = 3
        }
        let sectionInset = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? UIEdgeInsets.zero
        let collectionViewWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
        let fullContentInset: CGFloat = collectionView.contentInset.left + collectionView.contentInset.right
        let fullCectionInset: CGFloat = sectionInset.left + sectionInset.right
        let width = (collectionViewWidth - fullContentInset - fullCectionInset - (columns - 1) * space) / columns
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
        rootViewController?.pushViewController(detailViewController, animated: true)
    }
}
