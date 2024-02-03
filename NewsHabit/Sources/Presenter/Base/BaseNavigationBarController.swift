//
//  BaseNavigationBarController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/1/24.
//

import UIKit

import SnapKit
import Then

enum NavigationBarMode {
    case title
    case button
}

class NavigationItemBar: UIView {
    let backButton = UIButton().then {
        $0.tintColor = .label
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(
            systemName: "chevron.left",
            withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)
        )
    }
    
    let rightItemButton = UIButton().then {
        $0.tintColor = .label
        $0.configuration = .plain()
        $0.configuration?.image = UIImage(
            systemName: "square.and.arrow.up",
            withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)
        )
    }
    
    let largeTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 30, weight: .bold)
    }
    
    let subTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
}

protocol BaseNavigationBarViewControllerProtocol {
    var statusBar: UIView { get }
    var navigationItemBar: NavigationItemBar { get }
    var contentView: BaseView { get }
    
    func setupNavigationBar()
    func setBackgroundColor(_ color: UIColor?)
    func setNavigationBarMode(_ mode: NavigationBarMode)
    func setNavigationBarButtonTintColor(_ color: UIColor?)
    func setNavigationBarRightItemButtonHidden(_ hidden: Bool)
    func setNavigationBarRightItemButtonImage(_ image: UIImage?)
    func setNavigationBarRightItemButtonAction(_ selector: Selector)
    func setNavigationBarLargeTitleText(_ title: String?)
    func setNavigationBarLargeTitleTextColor(_ color: UIColor?)
    func setNavigationBarSubTitleText(_ title: String?)
    func setNavigationBarSubTitleTextColor(_ color: UIColor?)
}

class BaseNavigationBarController<View: BaseView>: UIViewController {
    
    // MARK: - UI Components
    
    let statusBar = UIView()
    let navigationItemBar = NavigationItemBar()
    let contentView: BaseView = View()
    
    // MARK: - Property
    
    var navigationBarHeight: CGFloat = 140.0
    
    // MARK: - Life Lycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .systemBackground
        setupLayout()
        setupGestureRecognizer()
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        view.addSubview(statusBar)
        view.addSubview(navigationItemBar)
        navigationItemBar.addSubview(navigationItemBar.backButton)
        navigationItemBar.addSubview(navigationItemBar.rightItemButton)
        navigationItemBar.addSubview(navigationItemBar.largeTitleLabel)
        navigationItemBar.addSubview(navigationItemBar.subTitleLabel)
        view.addSubview(contentView)
        
        statusBar.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        navigationItemBar.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        navigationItemBar.backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        navigationItemBar.rightItemButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        navigationItemBar.largeTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(20)
        }
        
        navigationItemBar.subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(navigationItemBar.largeTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(navigationItemBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabBarController?.tabBar.frame.height ?? 0)
        }
    }
    
    private func setupGestureRecognizer() {
        navigationItemBar.backButton.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleBackButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - BaseNavigationBarViewControllerProtocol
    
    /// 네비게이션 바의 초기 설정을 위해 반드시 서브클래스에서 재정의해야 하는 함수
    func setupNavigationBar() {
        fatalError("setupNavigationBar() must be overridden")
    }
    
    func setBackgroundColor(_ color: UIColor?) {
        statusBar.backgroundColor = color
        navigationItemBar.backgroundColor = color
        contentView.backgroundColor = color
    }
    
    func setNavigationBarMode(_ mode: NavigationBarMode) {
        if mode == .button {
            setNavigationBarButtonMode()
        } else {
            setNavigationBarTitleMode()
        }
        contentView.snp.remakeConstraints {
            $0.top.equalTo(navigationItemBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabBarController?.tabBar.frame.height ?? 0)
        }
    }
    
    private func setNavigationBarButtonMode() {
        navigationItemBar.backButton.isHidden = false
        navigationItemBar.rightItemButton.isHidden = false
        navigationItemBar.largeTitleLabel.isHidden = true
        navigationItemBar.subTitleLabel.isHidden = true
        navigationItemBar.snp.remakeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(60)
        }
    }
    
    private func setNavigationBarTitleMode() {
        navigationItemBar.backButton.isHidden = true
        navigationItemBar.rightItemButton.isHidden = true
        navigationItemBar.largeTitleLabel.isHidden = false
        navigationItemBar.subTitleLabel.isHidden = false
        navigationItemBar.snp.remakeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(110)
        }
    }
    
    func setNavigationBarButtonTintColor(_ color: UIColor?) {
        navigationItemBar.backButton.tintColor = color
        navigationItemBar.rightItemButton.tintColor = color
    }
    
    func setNavigationBarRightItemButtonHidden(_ hidden: Bool) {
        navigationItemBar.rightItemButton.isHidden = hidden
    }
    
    func setNavigationBarRightItemButtonImage(_ image: UIImage?) {
        navigationItemBar.rightItemButton.configuration?.image = image
    }
    
    func setNavigationBarRightItemButtonAction(_ selector: Selector) {
        navigationItemBar.rightItemButton.addTarget(self, action: selector, for: .touchUpInside)
    }
    
    func setNavigationBarLargeTitleText(_ title: String?) {
        navigationItemBar.largeTitleLabel.text = title
    }
    
    func setNavigationBarLargeTitleTextColor(_ color: UIColor?) {
        navigationItemBar.largeTitleLabel.textColor = color
    }
    
    func setNavigationBarSubTitleText(_ title: String?) {
        navigationItemBar.subTitleLabel.text = title
    }
    
    func setNavigationBarSubTitleTextColor(_ color: UIColor?) {
        navigationItemBar.subTitleLabel.textColor = color
    }
    
}
