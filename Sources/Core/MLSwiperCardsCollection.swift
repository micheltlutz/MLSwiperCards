//
//  MLSwiperCardsCollection.swift
//  MLSwiperCards
//
//  Created by Michel Anderson Lutz Teixeira on 28/03/19.
//  Copyright © 2019 micheltlutz. All rights reserved.
//

import UIKit

public class MLSwiperCardsCollection: UICollectionView {
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        return layout
    }()

    public init(cellSize: CGSize) {
        layout.itemSize = cellSize
        super.init(frame: .zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
