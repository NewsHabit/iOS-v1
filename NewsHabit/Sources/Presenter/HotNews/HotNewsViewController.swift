//
//  HotNewsViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/11/24.
//

import UIKit

protocol HotNewsViewDelegate {
    func updateDate()
    func pushViewController(_ newsLink: String?)
}

final class HotNewsViewController: BaseViewController<HotNewsView>, BaseViewControllerProtocol {
    
    private let viewModel = HotNewsViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        guard let contentView = contentView as? HotNewsView else { return }
        contentView.delegate = self
        contentView.bindViewModel(viewModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.send(.getHotNews)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarBackButtonHidden(true)
        setNavigationBarShareButtonHidden(true)
        setNavigationBarLargeTitle("🔥 지금 뜨는 뉴스")
        setNavigationBarSubTitleTextColor(.newsHabitGray)
    }
    
}

extension HotNewsViewController: HotNewsViewDelegate {
    
    func updateDate() {
        setNavigationBarSubTitle("\(Date().toFullDateTimeString()) 기준")
    }
    
    func pushViewController(_ newsLink: String?) {
        guard let newsLink = newsLink else { return }
        let newsViewController = WebViewController()
        newsViewController.urlString = newsLink
        navigationController?.pushViewController(newsViewController, animated: true)
    }
    
}

extension HotNewsViewController: Scrollable {
    
    func activateScroll() {
        guard let contentView = contentView as? HotNewsView else { return }
        let indexPath = IndexPath(row: 0, section: 0)
        // 테이블 뷰의 섹션 0에 적어도 하나 이상의 행이 있는지 확인
        if contentView.tableView.numberOfRows(inSection: indexPath.section) > 0 {
            contentView.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
}
