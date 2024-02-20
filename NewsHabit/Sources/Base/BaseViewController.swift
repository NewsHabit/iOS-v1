//
//  BaseViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/10/24.
//

import UIKit

import SnapKit
import Then

protocol BaseViewControllerProtocol {
    var statusBar: UIView { get }
    var navigationBar: NavigationBar { get }
    var contentView: UIView { get }
    
    func setupNavigationBar()
    func setBackgroundColor(_ color: UIColor?)
    func setNavigationBarTitle(_ title: String?)
    func setNavigationBarBackButtonHidden(_ hidden: Bool)
    func setNavigationBarLinkButtonHidden(_ hidden: Bool)
    func setNavigationBarLinkButtonAction(_ selector: Selector)
    func setNavigationBarLargeTitle(_ title: String?)
    func setNavigationBarLargeTitleTextColor(_ color: UIColor?)
    func setNavigationBarSubTitle(_ title: String?)
    func setNavigationBarSubTitleTextColor(_ color: UIColor?)
}

/// `BaseViewController`는 커스텀 네비게이션 바를 포함하는 기본 뷰 컨트롤러입니다.
/// 서브클래스에서 네비게이션 바를 설정하지 않으면, 모든 아이템이 기본적으로 보이는 상태로 시작합니다.
/// `setupNavigationBar` 메서드를 오버라이드하여 네비게이션 바를 커스텀 설정해야 합니다.
class BaseViewController<View: UIView>: UIViewController, BaseViewControllerProtocol {
    
    let statusBar = UIView()
    let navigationBar = NavigationBar()
    let contentView: UIView = View()
    
    // MARK: - Life Lycle
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .background
        setupHierarchy()
        setupLayout()
        setupGestureRecognizer()
    }
    
    // MARK: - Setup Methods
    
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
    
    private func setupGestureRecognizer() {
        navigationBar.backButton.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleBackButtonTap() {
        contentView.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        fatalError("\(type(of: self)): \(#function) must be overridden")
    }
    
    func setBackgroundColor(_ color: UIColor?) {
        view.backgroundColor = color
    }
    
    func setNavigationBarTitle(_ title: String?) {
        navigationBar.title.text = title
    }
    
    func setNavigationBarBackButtonHidden(_ hidden: Bool) {
        navigationBar.backButton.isHidden = hidden
    }
    
    func setNavigationBarLinkButtonHidden(_ hidden: Bool) {
        navigationBar.linkButton.isHidden = hidden
    }
    
    func setNavigationBarLinkButtonAction(_ selector: Selector) {
        navigationBar.linkButton.addTarget(self, action: selector, for: .touchUpInside)
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
    
}
