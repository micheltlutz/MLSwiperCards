//
//  ViewController.swift
//  MLSwiperCardsDemo
//
//  Created by Michel Anderson Lutz Teixeira on 28/03/19.
//  Copyright © 2019 micheltlutz. All rights reserved.
//

import UIKit
import MLSwiperCards

class CardsViewModel {
    var list: [MLSwiperCardsModel] = []

    func loadList() {
        list.append(MLSwiperCardsModel(title: "Title 1", description: "Description 1"))
        list.append(MLSwiperCardsModel(title: "Title 2", description: "Description 2"))
        list.append(MLSwiperCardsModel(description: "Description 3"))
        list.append(MLSwiperCardsModel(title: "Title 4", description: "Description 4"))
    }
}

class ViewController: UIViewController {
    
    private var swiperCards: MLSwiperCards!
    private let cardsViewModel = CardsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsViewModel.loadList()
        swiperCards = MLSwiperCards(data: cardsViewModel.list, cellSize: CGSize(width: 312, height: 152))
        swiperCards.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    private func setupView() {
        view.addSubview(swiperCards)
        NSLayoutConstraint.activate([
            swiperCards.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swiperCards.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            swiperCards.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            swiperCards.heightAnchor.constraint(equalToConstant: 182)
            ])
    }
}


