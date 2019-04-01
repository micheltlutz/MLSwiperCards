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
        list.append(MLSwiperCardsModel(title: "Libere todas as autoavaliações",
                                       description: "para acompanhar sua evolução, seus pontos fortes e fracos",
                                       fontTitle: UIFont.boldSystemFont(ofSize: 15),
                                       fontDescription: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)
            ))
        list.append(MLSwiperCardsModel(title: "Libere todas as sessões",
                                       description: "para melhorar seu bem-estar emocional pelo autoconhecimento",
                                       fontTitle: UIFont.boldSystemFont(ofSize: 15),
                                       fontDescription: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.light)))
        list.append(MLSwiperCardsModel(title: "Libere todas as técnicas SOS",
                                       description: "para lidar rapidamente com situações emocionais críticas"))
        list.append(MLSwiperCardsModel(description: "”É muito barato, pelo quanto me ajuda nas minhas emoções. É um método que funciona de verdade!”"))
    }
}

class ViewController: UIViewController {
    private var swiperCards: MLSwiperCards!
    private let cardsViewModel = CardsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        cardsViewModel.loadList()
        swiperCards = MLSwiperCards(data: cardsViewModel.list,
                                    cellSize: CGSize(width: 312, height: 152),
                                    pageConfig: nil)
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


