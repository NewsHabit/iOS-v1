//
//  BaseNavigationBarController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/1/24.
//

import UIKit

import SnapKit
import Then

class NavigationItemBar: UIView {
    var leftItemButton = UIButton()
    var rightItemButton = UIButton()
}

protocol BaseNavigationBarViewControllerProtocol {
    var statusBar: UIView { get }
    var navigationItemBar: NavigationItemBar { get }
    var contentView: BaseView { get }
    
    func setupNavigationBar()
    func setNavigationBarBackgroundColor(_ color: UIColor?)
    func setNavigationBarTintColor(_ color: UIColor?)
    func setNavigationBarHidden(_ hidden: Bool)
    func setNavigationBarLeftItemButtonHidden(_ hidden: Bool)
    func setNavigationBarRightItemButtonHidden(_ hidden: Bool)
    func setNavigationBarRightItemButtonImage(_ image: UIImage?)
    func setNavigationBarRightItemButtonAction(_ selector: Selector)
}

class BaseNavigationBarController<View: BaseView>: UIViewController, BaseNavigationBarViewControllerProtocol {
    
    // MARK: - UI
    
    let statusBar = UIView()
    
    let navigationItemBar = NavigationItemBar().then {
        $0.leftItemButton.tintColor = .label
        $0.leftItemButton.configuration = .plain()
        $0.leftItemButton.configuration?.image = UIImage(
            systemName: "chevron.left",
            withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)
        )
        $0.rightItemButton.tintColor = .label
        $0.rightItemButton.configuration = .plain()
        $0.rightItemButton.configuration?.image = UIImage(
            systemName: "square.and.arrow.up",
            withConfiguration: UIImage.SymbolConfiguration(weight: .semibold)
        )
    }
    
    let contentView: BaseView = View()
    
    // MARK: - Life Lycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .systemBackground
        setupLayout()
    }
    
    // MARK: - BaseNavigationBarViewControllerProtocol
    
    func setupNavigationBar() {
        fatalError("setupNavigationBar() must be overridden")
    }
    
    func setNavigationBarBackgroundColor(_ color: UIColor?) {
        statusBar.backgroundColor = color
        navigationItemBar.backgroundColor = color
    }
    
    func setNavigationBarTintColor(_ color: UIColor?) {
        navigationItemBar.leftItemButton.tintColor = color
        navigationItemBar.rightItemButton.tintColor = color
    }
    
    func setNavigationBarHidden(_ hidden: Bool) {
        navigationItemBar.isHidden = hidden
        
        if hidden {
            contentView.snp.remakeConstraints {
                $0.top.equalTo(statusBar.snp.bottom)
                $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                $0.bottom.equalToSuperview()
            }
        } else {
            contentView.snp.remakeConstraints {
                $0.top.equalTo(statusBar.snp.bottom).offset(60)
                $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
                $0.bottom.equalToSuperview()
            }
        }
    }
    
    func setNavigationBarLeftItemButtonHidden(_ hidden: Bool) {
        navigationItemBar.leftItemButton.isHidden = hidden
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
    
    // MARK: - functions
    
    private func setupLayout() {
        view.addSubview(statusBar)
        view.addSubview(navigationItemBar)
        navigationItemBar.addSubview(navigationItemBar.leftItemButton)
        navigationItemBar.addSubview(navigationItemBar.rightItemButton)
        view.addSubview(contentView)
        
        statusBar.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        navigationItemBar.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        navigationItemBar.leftItemButton.snp.makeConstraints {
            $0.left.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        navigationItemBar.rightItemButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        contentView.snp.makeConstraints {
            $0.top.equalTo(statusBar.snp.bottom).offset(60)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(tabBarController?.tabBar.frame.height ?? 0)
        }
    }
    
}
