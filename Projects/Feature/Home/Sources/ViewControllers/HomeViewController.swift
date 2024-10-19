//
//  HomeViewController.swift
//  FeatureHome
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import Shared

public final class HomeViewController: ViewController<HomeView> {
    private let dailyNewsDataSource = DailyNewsDataSource()
    private let bookmarkDataSource = BookmarkDataSource()
    
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
        dailyNewsCollectionView.delegate = self
        dailyNewsCollectionView.dataSource = dailyNewsDataSource
        
        bookmarkCollectionView.delegate = self
        bookmarkCollectionView.dataSource = bookmarkDataSource
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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

private extension HomeViewController {
    var dailyNewsCollectionView: UICollectionView {
        contentView.dailyNewsView.collectionView
    }
    
    var bookmarkCollectionView: UICollectionView {
        contentView.bookmarkView.collectionView
    }
}

// TODO: 임시! Diffable Data Source로 바꿀 것

class DailyNewsDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: NewsCell.self)
        cell.configure(with: .daily)
        return cell
    }
}

class BookmarkDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: NewsCell.self)
        cell.configure(with: .bookmark)
        return cell
    }
}
