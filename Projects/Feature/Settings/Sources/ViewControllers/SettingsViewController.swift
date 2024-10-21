//
//  SettingsViewController.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import UIKit

import Shared

public final class SettingsViewController:ViewController<SettingsView> {
    private let settings: [[SettingsType]] = [
        [.name, .category, .newsCount, .notification],
        [.developer, .reset]
    ]
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeNavigationBar(title: "설정")
        setupCollectionView()
    }
    
    // MARK: - Setup Methods
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SettingsViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let settingType = settings[indexPath.section][indexPath.row]
        switch settingType {
        case .name:         navigate(to: NameViewController())
        case .category:     navigate(to: CategoryViewController())
        case .newsCount:    navigate(to: NewsCountViewController())
        case .notification: navigate(to: NotificationViewController())
        case .developer:
            let viewController = WebViewController()
            viewController.setupToolBar(isBookmarkButtonHidden: true)
            navigate(to: viewController)
        case .reset:        print("reset")
        }
    }
    
    private func navigate(to viewContoller: UIViewController) {
        navigationController?.pushViewController(viewContoller, animated: true)
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 52)
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        if section == 0 {
            return .zero
        } else {
            return CGSize(width: collectionView.frame.width, height: 30)
        }
    }
}

extension SettingsViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return settings.count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return settings[section].count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SettingsCell.self)
        cell.configure(with: settings[indexPath.section][indexPath.row])
        return cell
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath)
        }
        return UICollectionReusableView()
    }
}

private extension SettingsViewController {
    var collectionView: UICollectionView {
        contentView.collectionView
    }
}
