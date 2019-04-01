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
    private var nextIndex: Int = 0
    private var timer: Timer!
    private var indexOfCellBeforeDragging = 0
    private var cellSize: CGSize!
    private var autoScroll = true
    var delayTimer: Double = 0.5
    var repeatTimer: Double = 5.0

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.purple
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    public init(data: [MLSwiperCardsModel], cellSize: CGSize, pageConfig: (pageIndicator: UIColor, currentPageIndicator: UIColor)?) {
        super.init(frame: .zero)
        self.data = data
        self.cellSize = cellSize
        collection = MLSwiperCardsCollection(cellSize: cellSize)
        collection.delegate = self
        collection.dataSource = self
        collection.register(MLSwiperCardCell.self, forCellWithReuseIdentifier: cellID)
        frame = CGRect(x: 0, y: 0, width: cellSize.width, height: cellSize.height)
        setupViewConfiguration()

//        DispatchQueue.main.asyncAfter(deadline: .now() + delayTimer) {
//            self.timer = Timer.scheduledTimer(withTimeInterval: self.repeatTimer, repeats: true) { _ in
//                self.autoScrollCards()
//            }
//        }
    }

    func autoScrollCards() {
        nextIndex = pageControl.currentPage + 1
        if nextIndex >= pageControl.numberOfPages {
            nextIndex = 0
            pageControl.currentPage = 0
        } else {
            pageControl.currentPage = nextIndex
        }
        let indexPath = IndexPath(item: nextIndex, section: 0)
        self.collection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    private func calculateSectionInset() -> CGFloat {
        let deviceIsIpad = UIDevice.current.userInterfaceIdiom == .pad
        let deviceOrientationIsLandscape = UIDevice.current.orientation.isLandscape
        let cellBodyViewIsExpended = deviceIsIpad || deviceOrientationIsLandscape
        let cellBodyWidth: CGFloat = collection.layout.itemSize.width + (cellBodyViewIsExpended ? 174 : 0)

        let buttonWidth: CGFloat = 50

//        let inset = (collection.frame.width - cellBodyWidth + buttonWidth) / 4
        let inset = (collection.frame.width - cellBodyWidth + buttonWidth) / CGFloat(pageControl.numberOfPages)
        print("inset")
        print(inset)
        return inset
    }

    private func configureCollectionViewLayoutItemSize() {
        let inset: CGFloat = calculateSectionInset()
        collection.layout.itemSize = CGSize(width: collection.frame.size.width - inset * 2, height: collection.frame.size.height)
    }

    private func indexOfMajorCell() -> Int {
        let itemWidth = collection.layout.itemSize.width
        let proportionalOffset = collection.contentOffset.x / itemWidth
        let index = Int(round(proportionalOffset))
        let safeIndex = max(0, min(data.count - 1, index))
        return safeIndex
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

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfMajorCell()
    }



    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if autoScroll {
//            self.timer.invalidate()
            autoScroll = false
        }
        // Stop scrollView sliding:
        targetContentOffset.pointee = scrollView.contentOffset

        // calculate where scrollView should snap to:
        let indexOfMajorCell = self.indexOfMajorCell()

        // calculate conditions:
        let swipeVelocityThreshold: CGFloat = 0.5 // after some trail and error
        let hasEnoughVelocityToSlideToTheNextCell = indexOfCellBeforeDragging + 1 < data.count && velocity.x > swipeVelocityThreshold
        let hasEnoughVelocityToSlideToThePreviousCell = indexOfCellBeforeDragging - 1 >= 0 && velocity.x < -swipeVelocityThreshold
        let majorCellIsTheCellBeforeDragging = indexOfMajorCell == indexOfCellBeforeDragging
        let didUseSwipeToSkipCell = majorCellIsTheCellBeforeDragging && (hasEnoughVelocityToSlideToTheNextCell || hasEnoughVelocityToSlideToThePreviousCell)

        if didUseSwipeToSkipCell {

            let snapToIndex = indexOfCellBeforeDragging + (hasEnoughVelocityToSlideToTheNextCell ? 1 : -1)
            let toValue = collection.layout.itemSize.width * CGFloat(snapToIndex)

            // Damping equal 1 => no oscillations => decay animation:
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: velocity.x, options: .allowUserInteraction, animations: {
                scrollView.contentOffset = CGPoint(x: toValue, y: 0)
                scrollView.layoutIfNeeded()
            }, completion: nil)

        } else {
            // This is a much better way to scroll to a cell:
            pageControl.currentPage = indexOfMajorCell
            let indexPath = IndexPath(row: indexOfMajorCell, section: 0)
            collection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
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
