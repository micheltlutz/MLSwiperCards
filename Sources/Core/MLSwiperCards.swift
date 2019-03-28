//
//  MLSwiperCards.swift
//  MLSwiperCards
//
//  Created by Michel Lutz & Marcos Lacerda on 02/10/17.
//  Copyright © 2017 micheltlutz. All rights reserved.
//

import UIKit

public class MLSwiperCards: UIView {
    public static let name = "MLSwiperCards"

    private var collection: MLSwiperCardsCollection!
    public var numberOfPages: Int = 0 {
        didSet {
            pageControl.numberOfPages = numberOfPages
        }
    }

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .red
        return pageControl
    }()

    public init(cellSize: CGSize) {
        super.init(frame: .zero)
        collection = MLSwiperCardsCollection(cellSize: cellSize)
        setupViewConfiguration()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MLSwiperCards: MLViewConfiguration {
    func setupConstraints() {
        collection.pinEdgesToSuperview()
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }

    func buildViewHierarchy() {
        addSubview(collection)
        addSubview(pageControl)
    }


}
