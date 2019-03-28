//
//  MLSwiperCardsModel.swift
//  MLSwiperCards
//
//  Created by Michel Anderson Lutz Teixeira on 28/03/19.
//  Copyright © 2019 Cingulo. All rights reserved.
//

import UIKit

public struct MLSwiperCardsModel {
    var title: String?
    var description: String
    var image: UIImage?
}

extension MLSwiperCardsModel {
    public init(description: String) {
        self.description = description
    }

    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }

    public init(title: String, description: String, image: UIImage) {
        self.title = title
        self.description = description
        self.image = image
    }

    public init(description: String, image: UIImage) {
        self.description = description
        self.image = image
    }
}
