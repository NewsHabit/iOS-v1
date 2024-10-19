//
//  HomeViewController.swift
//  FeatureHome
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import Shared

public final class HomeViewController: ViewController<HomeView> {
    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeNavigationBar(
            title: "구지옹님의 뉴빗",
            subTitle: "👀 지금까지 38일 완독했어요!"
        )
        setBackgroundColor(Colors.secondaryBackground)
        setTitleColor(UIColor.white)
        setupCollectionView()
    }
    
    // MARK: - Setup Methods
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 95)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 3
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: NewsCell.self)
        cell.configure(with: .daily)
        return cell
    }
}

private extension HomeViewController {
    var collectionView: UICollectionView {
        contentView.dailyNewsView.collectionView
    }
}
