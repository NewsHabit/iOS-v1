//
//  BaseViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/10/24.
//

import UIKit

import SnapKit
import Then

class BaseViewController<View: UIView>: UIViewController, UIGestureRecognizerDelegate {
    
    let statusBar = UIView()
    let navigationBar = NavigationBar()
    let contentView = View()
    
    // MARK: - Life Lycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperty()
        setupHierarchy()
        setupLayout()
        setupBackButtonAction()
    }
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        view.backgroundColor = .background
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    private func setupHierarchy() {
        view.addSubview(statusBar)
        view.addSubview(navigationBar)
        view.addSubview(contentView)
    }
    
    private func setupLayout() {
        statusBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabBarController?.tabBar.frame.height ?? 0)
        }
    }
    
    private func setupBackButtonAction() {
        navigationBar.backButton.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleBackButtonTap() {
        contentView.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Setup NavigationBar Methods
    
    func setBackgroundColor(_ color: UIColor?) {
        view.backgroundColor = color
    }
    
    func setNavigationBarTitle(_ title: String?) {
        navigationBar.title.text = title
    }
    
    func setNavigationBarBackButtonHidden(_ hidden: Bool) {
        navigationBar.backButton.isHidden = hidden
    }
    
    func setNavigationBarShareButtonHidden(_ hidden: Bool) {
        navigationBar.shareButton.isHidden = hidden
    }
    
    func setNavigationBarShareButtonAction(_ selector: Selector) {
        navigationBar.shareButton.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    func setNavigationBarLargeTitle(_ title: String?) {
        navigationBar.largeTitle.text = title
    }
    
    func setNavigationBarLargeTitleTextColor(_ color: UIColor?) {
        navigationBar.largeTitle.textColor = color
    }
    
    func setNavigationBarSubTitle(_ title: String?) {
        navigationBar.subTitle.text = title
    }
    
    func setNavigationBarSubTitleTextColor(_ color: UIColor?) {
        navigationBar.subTitle.textColor = color
    }
    
    // MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigationController = navigationController else { return false }
        // Navigation Stack에 쌓인 뷰가 1개를 초과할 때 스와이프 제스처 허용
        return navigationController.viewControllers.count > 1
    }
    
}
