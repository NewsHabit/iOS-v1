//
//  MainView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/1/24.
//

import Combine
import UIKit

import SnapKit
import Then

class MainView: BaseView {
    
    // MARK: - Properties
    
    var viewModel: MainViewModel?
    
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - UI
    
    let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner] // 위쪽 모서리 둥글게
    }
    
    let todayNewsLabel = UILabel().then {
        $0.text = "오늘의 뉴스"
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.isUserInteractionEnabled = true
    }
    
    let monthlyRecordLabel = UILabel().then {
        $0.text = "이번 달 기록"
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.isUserInteractionEnabled = true
    }
    
    let separator = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    let indicator = UIView().then {
        $0.backgroundColor = .label
    }
    
    let scrollView = UIScrollView().then {
        $0.isPagingEnabled = true
        $0.isScrollEnabled = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    let todayNewsView = UIView().then {
        $0.backgroundColor = .systemPink.withAlphaComponent(0.1)
    }
    
    let monthlyRecordView = UIView().then {
        $0.backgroundColor = .systemYellow.withAlphaComponent(0.1)
    }
    
    // MARK: - initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseViewProtocol
    
    override func setupLayout() {
        addSubview(backgroundView)
        addSubview(todayNewsLabel)
        addSubview(monthlyRecordLabel)
        addSubview(separator)
        addSubview(indicator)
        addSubview(scrollView)
        scrollView.addSubview(todayNewsView)
        scrollView.addSubview(monthlyRecordView)
        
        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        todayNewsLabel.snp.makeConstraints {
            $0.top.equalTo(backgroundView.snp.top).offset(60)
            $0.leading.equalToSuperview().inset(25)
        }
        
        monthlyRecordLabel.snp.makeConstraints {
            $0.top.equalTo(todayNewsLabel.snp.top)
            $0.leading.equalTo(todayNewsLabel.snp.trailing).offset(20)
        }
        
        separator.snp.makeConstraints {
            $0.top.equalTo(todayNewsLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        indicator.snp.makeConstraints {
            $0.width.equalTo(monthlyRecordLabel.snp.width)
            $0.height.equalTo(3)
            $0.centerY.equalTo(separator.snp.centerY)
            $0.centerX.equalTo(todayNewsLabel.snp.centerX)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(separator.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        todayNewsView.snp.makeConstraints {
            $0.top.height.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        
        monthlyRecordView.snp.makeConstraints {
            $0.top.height.equalToSuperview()
            $0.leading.equalTo(todayNewsView.snp.trailing)
            $0.width.equalTo(scrollView.snp.width)
            $0.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Setup Gesture Recognizer
    
    private func setupGestureRecognizer() {
        todayNewsLabel.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(handleTodayNewsTap))
        )
        monthlyRecordLabel.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(handleMonthlyRecordTap))
        )
    }
    
    @objc private func handleTodayNewsTap() {
        viewModel?.selectedMenu = .todayNews
    }
    
    @objc private func handleMonthlyRecordTap() {
        viewModel?.selectedMenu = .monthlyRecord
    }
    
    // MARK: - Bind View Model
    
    func bindViewModel(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        viewModel.$selectedMenu
            .receive(on: RunLoop.main)
            .sink { [weak self] selectedMenu in
                self?.updateMenuPosition(for: selectedMenu)
            }
            .store(in: &cancellables)
    }
    
    private func updateMenuPosition(for menu: MainViewModel.MenuOption) {
        let indicatorPosition = menu == .todayNews ? todayNewsLabel : monthlyRecordLabel
        let viewOffset = menu == .todayNews ? CGPoint(x: 0, y: 0) : CGPoint(x: scrollView.frame.width, y: 0)
        
        UIView.animate(withDuration: 0.2) {
            self.indicator.snp.remakeConstraints {
                $0.width.equalTo(indicatorPosition.snp.width)
                $0.height.equalTo(3)
                $0.centerY.equalTo(self.separator.snp.centerY)
                $0.centerX.equalTo(indicatorPosition.snp.centerX)
            }
            self.scrollView.setContentOffset(viewOffset, animated: true)
            self.layoutIfNeeded()
        }
    }
    
}
