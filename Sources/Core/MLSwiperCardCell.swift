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
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
        return titleLabel
    }()

    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        return descriptionLabel
    }()

    private var topDistance: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        setupViewConfiguration()
    }

    /**
     @TODO: model.image pode ser usado para background do card
     */
    public func configure(with model: MLSwiperCardsModel) {
        if let title = model.title {
            titleLabel.text = title
            topDistance?.constant = 32
        } else {
            topDistance?.constant = 16
        }
        descriptionLabel.text = model.description
        setupFont(with: model)
    }

    private func setupFont(with model: MLSwiperCardsModel) {
        if let fontTitle = model.fontTitle {
            titleLabel.font = fontTitle
        }

        if let fontDescription = model.fontDescription {
            descriptionLabel.font = fontDescription
        }
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MLSwiperCardCell: MLViewConfiguration {
    func setupConstraints() {
        topDistance = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 32)
        NSLayoutConstraint.activate([
            topDistance!,
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
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

