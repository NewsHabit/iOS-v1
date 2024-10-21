//
//  HomeView.swift
//  FeatureHome
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import Shared

public final class HomeView: UIView {
    private let homeTabs = HomeTab.allCases
    private var indicatorLeadingConstraint: Constraint?
    private var indicatorWidthConstraint: Constraint?
    private var isInitialLayoutCompleted = false
    private var titleLabels: [UILabel] = []
    
    // MARK: - Components
    
    private let containerView = {
        let view = UIView()
        view.backgroundColor = Colors.background
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let titleContainer = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    private let line = {
        let view = UIView()
        view.backgroundColor = Colors.gray01
        return view
    }()
    
    private let indicator = {
        let view = UIView()
        view.backgroundColor = Colors.gray09
        return view
    }()
    
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let dailyNewsView = DailyNewsView()
    
    let monthlyRecordView = MonthlyRecordView()
    
    let bookmarkView = BookmarkView()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupTitleContainer()
        setupScrollView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isInitialLayoutCompleted {
            setupInitialAppearance()
            isInitialLayoutCompleted = true
        }
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        containerView.addSubview(titleContainer)
        titleContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(46)
        }
        
        containerView.addSubview(line)
        line.snp.makeConstraints { make in
            make.bottom.equalTo(titleContainer.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        
        line.addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.height.centerY.equalToSuperview()
            self.indicatorLeadingConstraint = make.leading.equalTo(titleContainer).constraint
            self.indicatorWidthConstraint = make.width.equalTo(0).constraint
        }
        
        containerView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(16)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    private func setupTitleContainer() {
        for (index, tab) in homeTabs.enumerated() {
            let label = createTitleLabel(with: tab.title)
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(
                target: self,
                action: #selector(titleLabelTapped)
            )
            label.addGestureRecognizer(tapGesture)
            label.tag = index
            titleContainer.addArrangedSubview(label)
            titleLabels.append(label)
        }
        
        let emptyView = UIView()
        titleContainer.addArrangedSubview(emptyView)
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
        
        [dailyNewsView, monthlyRecordView, bookmarkView].forEach { view in
            contentView.addArrangedSubview(view)
            view.snp.makeConstraints { make in
                make.width.equalTo(scrollView)
            }
        }
    }
    
    private func setupInitialAppearance() {
        guard let firstLabel = titleContainer.arrangedSubviews.first as? UILabel else { return }
        
        layoutIfNeeded()
        
        firstLabel.textColor = Colors.gray09
        titleLabels.dropFirst().forEach { $0.textColor = Colors.gray03 }
        
        indicatorLeadingConstraint?.update(offset: firstLabel.frame.minX)
        indicatorWidthConstraint?.update(offset: firstLabel.frame.width)
        
        UIView.performWithoutAnimation {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func titleLabelTapped(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel else { return }
        let index = label.tag
        
        let xOffset = CGFloat(index) * scrollView.bounds.width
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
        
        updateIndicatorPosition(toIndex: index)
        updateTitleColors(selectedIndex: index)
    }
    
    private func updateIndicatorPosition(toIndex: Int) {
        guard let toLabel = titleContainer.arrangedSubviews[toIndex] as? UILabel else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.indicatorLeadingConstraint?.update(offset: toLabel.frame.minX)
            self.indicatorWidthConstraint?.update(offset: toLabel.frame.width)
            self.layoutIfNeeded()
        }
    }
    
    private func updateTitleColors(selectedIndex: Int) {
        titleLabels.enumerated().forEach { index, label in
            label.textColor = index == selectedIndex ? Colors.gray09 : Colors.gray03
        }
    }
}

private extension HomeView {
    func createTitleLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = Fonts.title2
        label.textColor = Colors.gray09
        return label
    }
}

extension HomeView: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        updateIndicatorPosition(toIndex: index)
        updateTitleColors(selectedIndex: index)
    }

    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        updateIndicatorPosition(toIndex: index)
        updateTitleColors(selectedIndex: index)
    }
}
