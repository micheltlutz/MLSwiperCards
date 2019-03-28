//
//  MLSwiperCardsCollection.swift
//  MLSwiperCards
//
//  Created by Michel Anderson Lutz Teixeira on 28/03/19.
//  Copyright © 2019 micheltlutz. All rights reserved.
//

import UIKit

public class MLSwiperCardsCollection: UICollectionView {
    public init(cellSize: CGSize) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        super.init(frame: .zero, collectionViewLayout: layout)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .green
        isPagingEnabled = true
        showsHorizontalScrollIndicator = false
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
