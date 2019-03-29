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
    private let cellID = "cardCell"
    var data: [MLSwiperCardsModel] = []
    public private(set) var collection: MLSwiperCardsCollection!
    public var numberOfPages: Int = 0 {
        didSet {
            pageControl.numberOfPages = numberOfPages
        }
    }

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.gray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    public init(data: [MLSwiperCardsModel], cellSize: CGSize, pageConfig: (pageIndicator: UIColor, currentPageIndicator: UIColor)?) {
        super.init(frame: .zero)
        self.data = data
        collection = MLSwiperCardsCollection(cellSize: cellSize)
        collection.delegate = self
        collection.dataSource = self
        collection.register(MLSwiperCardCell.self, forCellWithReuseIdentifier: cellID)
        frame = CGRect(x: 0, y: 0, width: cellSize.width, height: cellSize.height)
        setupViewConfiguration()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MLSwiperCards: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itens = data.count
        numberOfPages = itens
        return itens
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? MLSwiperCardCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: data[indexPath.row])
        cell.prepareForReuse()
        return cell
    }
}

extension MLSwiperCards: UICollectionViewDelegateFlowLayout {
    private func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let cellWidth: CGFloat = 312.0 // Your cell width
        
        let numberOfCells = UIScreen.main.bounds.width / cellWidth
        let edgeInsets = (UIScreen.main.bounds.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)
        
        return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets)
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
    
//    func configureViews() {
//        backgroundColor = .red
//    }
}
