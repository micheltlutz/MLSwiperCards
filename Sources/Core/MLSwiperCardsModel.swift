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
    var fontTitle: UIFont?
    var fontDescription: UIFont?
}

extension MLSwiperCardsModel {
    public init(description: String) {
        self.description = description
    }

    public init(description: String, fontDescription: UIFont) {
        self.description = description
        self.fontDescription = fontDescription
    }

    public init(title: String, description: String) {
        self.title = title
        self.description = description
    }

    public init(title: String, description: String, fontTitle: UIFont, fontDescription: UIFont) {
        self.title = title
        self.description = description
        self.fontTitle = fontTitle
        self.fontDescription = fontDescription
    }

    public init(title: String, description: String, image: UIImage) {
        self.title = title
        self.description = description
        self.image = image
    }

    public init(title: String, description: String, image: UIImage, fontTitle: UIFont, fontDescription: UIFont) {
        self.title = title
        self.description = description
        self.image = image
        self.fontTitle = fontTitle
        self.fontDescription = fontDescription
    }

    public init(description: String, image: UIImage) {
        self.description = description
        self.image = image
    }

    public init(description: String, image: UIImage, fontDescription: UIFont) {
        self.description = description
        self.image = image
        self.fontDescription = fontDescription
    }
}
