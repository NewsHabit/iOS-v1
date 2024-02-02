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
    var backButton = UIButton()
    var rightItemButton = UIButton()
    var largeTitleLabel = UILabel()
    var subTitleLabel = UILabel()
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

class BaseNavigationBarController<View: BaseView>: UIViewController, BaseNavigationBarViewControllerProtocol {
    
    // MARK: - UI
    
    let statusBar = UIView()
    
    let navigationItemBar = NavigationItemBar().then {
        $0.backButton.tintColor = .label
        $0.backButton.configuration = .plain()
        $0.backButton.configuration?.image = UIImage(
            systemName: "chevron.left",
            withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)
        )
        $0.rightItemButton.tintColor = .label
        $0.rightItemButton.configuration = .plain()
        $0.rightItemButton.configuration?.image = UIImage(
            systemName: "square.and.arrow.up",
            withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)
        )
        $0.largeTitleLabel.font = .systemFont(ofSize: 30, weight: .bold)
        $0.subTitleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    let contentView: BaseView = View()
    
    // MARK: - Property
    
    var navigationBarHeight: CGFloat = 140.0
    
    // MARK: - Life Lycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    // MARK: - BaseNavigationBarViewControllerProtocol
    
    func setupNavigationBar() {
        fatalError("setupLayout() must be overridden")
    }
    
    func setBackgroundColor(_ color: UIColor?) {
        statusBar.backgroundColor = color
        navigationItemBar.backgroundColor = color
        contentView.backgroundColor = color
    }
    
    func setNavigationBarMode(_ mode: NavigationBarMode) {
        if mode == .button {
            navigationItemBar.backButton.isHidden = false
            navigationItemBar.rightItemButton.isHidden = false
            navigationItemBar.largeTitleLabel.isHidden = true
            navigationItemBar.subTitleLabel.isHidden = true
            navigationItemBar.snp.remakeConstraints {
                $0.top.equalTo(statusBar.snp.bottom)
                $0.left.right.equalToSuperview()
                $0.height.equalTo(60)
            }
        } else {
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
        contentView.snp.remakeConstraints {
            $0.top.equalTo(navigationItemBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabBarController?.tabBar.frame.height ?? 0)
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
        navigationItemBar.rightItemButton.addTarget(nil, action: selector, for: .touchUpInside)
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
    
    // MARK: - functions
    
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
    
}
