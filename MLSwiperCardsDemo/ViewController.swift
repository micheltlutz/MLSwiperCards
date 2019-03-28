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
    private let cellID = "cardCell"
    private let swiperCards = MLSwiperCards(cellSize: CGSize(width: 312, height: 152))
    private let cardsViewModel = CardsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        swiperCards.delegate = self
        swiperCards.dataSource = self
        swiperCards.register(MLSwiperCardCell.self, forCellWithReuseIdentifier: cellID)
        cardsViewModel.loadList()
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

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itens = cardsViewModel.list.count
        swiperCards.numberOfPages = itens
        return itens
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? MLSwiperCardCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: cardsViewModel.list[indexPath.row])
        cell.prepareForReuse()
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let cellWidth: CGFloat = 312.0 // Your cell width

        let numberOfCells = UIScreen.main.bounds.width / cellWidth
        let edgeInsets = (UIScreen.main.bounds.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)

        return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets)
    }
}
