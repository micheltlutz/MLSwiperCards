// swift-tools-version:4.2
//
//  MLSwiperCards.swift
//  MLSwiperCards
//
//  Created by Michel Lutz & Marcos Lacerda on 23/10/15.
//  Copyright © 2017 micheltlutz. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "MLSwiperCards",
    products: [
        .library(
            name: "MLSwiperCards",
            targets: ["MLSwiperCards"]),
        ],
    dependencies: [],
    targets: [
        .target(
            name: "MLSwiperCards",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "MLSwiperCardsTests",
            dependencies: ["MLSwiperCards"],
            path: "Tests")
    ]
)
