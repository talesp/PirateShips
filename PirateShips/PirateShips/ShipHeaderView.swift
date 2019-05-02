//
//  ShipHeaderView.swift
//  PirateShips
//
//  Created by Tales Pinheiro De Andrade on 27/04/19.
//  Copyright © 2019 tales.andrade. All rights reserved.
//

import UIKit

class ShipHeaderView: UIView {

    private var titleContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.18)
        view.layer.cornerRadius = 4.0
        return view
    }()

    private(set) var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .headline)
        view.textColor = .white
        view.numberOfLines = 2
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return view
    }()

    private var priceContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.18)
        view.layer.cornerRadius = 4.0
        return view
    }()

    private(set) var priceLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.preferredFont(forTextStyle: .title2)
        view.textColor = .white
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return view
    }()

    private(set) var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = UIView.ContentMode.scaleAspectFill
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        view.clipsToBounds = true
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

    func setup(title: String, price: Int, imageURL: String) {
        titleLabel.text = title
        priceLabel.text = "$ \(price)"
        guard let url = URL(string: imageURL) else { return }
        imageView.kf.setImage(with: url)
    }
}

extension ShipHeaderView: ViewConfiguration {
    func buildViewHierarchy() {
        addSubview(imageView)

        priceContainer.addSubview(priceLabel)
        addSubview(priceContainer)

        titleContainer.addSubview(titleLabel)
        addSubview(titleContainer)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])

        NSLayoutConstraint.activate([
        	priceLabel.topAnchor.constraint(equalTo: priceContainer.topAnchor, constant: priceContainer.directionalLayoutMargins.top),
        	priceLabel.leadingAnchor.constraint(equalTo: priceContainer.leadingAnchor, constant: priceContainer.directionalLayoutMargins.leading),
        	priceLabel.bottomAnchor.constraint(equalTo: priceContainer.bottomAnchor, constant: -priceContainer.directionalLayoutMargins.bottom),
        	priceLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor, constant: -priceContainer.directionalLayoutMargins.trailing)
        ])
        
        NSLayoutConstraint.activate([
            priceContainer.topAnchor.constraint(equalTo: self.topAnchor, constant: self.directionalLayoutMargins.top),
            priceContainer.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: self.directionalLayoutMargins.leading),
        	priceContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.directionalLayoutMargins.trailing)
         ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor, constant: titleContainer.directionalLayoutMargins.top),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor, constant: titleContainer.directionalLayoutMargins.leading),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: -titleContainer.directionalLayoutMargins.bottom),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor, constant: -titleContainer.directionalLayoutMargins.trailing)
            ])

         NSLayoutConstraint.activate([
         	titleContainer.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.directionalLayoutMargins.leading),
         	titleContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -self.directionalLayoutMargins.bottom),
            titleContainer.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -self.directionalLayoutMargins.trailing),
            titleContainer.topAnchor.constraint(greaterThanOrEqualTo: priceContainer.bottomAnchor, constant: self.directionalLayoutMargins.top),

         ])
    }

    func configureViews() {
        backgroundColor = .lightGray
    }

}
