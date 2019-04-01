//
//  MLSwiperCardCell.swift
//  MLSwiperCards
//
//  Created by Michel Anderson Lutz Teixeira on 28/03/19.
//  Copyright © 2019 Cingulo. All rights reserved.
//

import UIKit

public class MLSwiperCardCell: UICollectionViewCell {
    private var viewController: UIViewController!
    private let stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.textAlignment = .center
        return titleLabel
    }()

    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.textAlignment = .center
        return descriptionLabel
    }()
    /**
     @TODO: model.image pode ser usado para background do card
     */
    public func configure(with model: MLSwiperCardsModel) {
        if let title = model.title {
            titleLabel.text = title
            stackView.addArrangedSubview(titleLabel)
        }
        descriptionLabel.text = model.description
        stackView.addArrangedSubview(descriptionLabel)
        setupViewConfiguration()
    }
}

extension MLSwiperCardCell: MLViewConfiguration {
    func setupConstraints() {
        stackView.pinEdgesToSuperview()
    }

    func buildViewHierarchy() {
        addSubview(stackView)
    }

    func configureViews() {
        backgroundColor = .white
        layer.cornerRadius = 24
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.16
        layer.shadowOffset = CGSize(width: 0, height: 5.0)
    }
}

