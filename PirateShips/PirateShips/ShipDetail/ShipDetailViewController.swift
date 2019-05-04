//
//  ShipDetailViewController.swift
//  PirateShips
//
//  Created by Tales Pinheiro De Andrade on 01/05/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import UIKit

class ShipDetailViewController: UIViewController {
    private(set) lazy var shipDetailView: ShipDetailView = ShipDetailView()
    private var greeting: Greeting?

    override func loadView() {
        view = shipDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Greetings", style: .plain, target: self, action: #selector(greetings(sender:)))
    }

    @objc
    func greetings(sender: UIBarButtonItem) {
        let title = greeting?.description !! "Bad Pirate. You forgot to set the greeting"
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }

    func setup(title: String, price: Int, description: String, image: String, greeting: Greeting) {
        shipDetailView.setup(title: title, price: price, description: description, image: image)
        self.greeting = greeting
        self.title = title
    }
}

class ShipDetailView: UIView {
    private var shipHeaderView: ShipHeaderView = {
        let view = ShipHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var descriptionTextView: UITextView = {
        let view = UITextView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = false
        view.isSelectable = true
        view.font = UIFont.preferredFont(forTextStyle: .title3)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConfiguration()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(title: String, price: Int, description: String, image: String) {
        shipHeaderView.setup(title: title, price: price, imageURL: image)
        descriptionTextView.text = description
    }
}

extension ShipDetailView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(shipHeaderView)
        addSubview(descriptionTextView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            shipHeaderView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            shipHeaderView.heightAnchor.constraint(equalToConstant: 300),
            shipHeaderView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            shipHeaderView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])

        NSLayoutConstraint.activate([
            descriptionTextView.topAnchor.constraint(equalTo: shipHeaderView.bottomAnchor, constant: self.layoutMargins.bottom),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    func configureViews() {
        backgroundColor = .white
    }
}
