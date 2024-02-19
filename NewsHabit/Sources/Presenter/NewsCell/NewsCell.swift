//
//  NewsCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Combine
import UIKit

import SnapKit
import Then

class NewsCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "NewsCell"
    var viewModel: NewsCellViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
    }
    
    let isReadView = UIView().then {
        $0.backgroundColor = .newsHabitAccent
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 3
    }
    
    let titleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .cellTitleFont
    }
    
    let descriptionLabel = UILabel().then {
        $0.textColor = .newsHabitGray
        $0.font = .cellLabelFont
        $0.numberOfLines = 3
        $0.lineBreakMode = .byTruncatingTail
    }
    
    let categoryLabel = UILabel().then {
        $0.textColor = .systemBackground
        $0.textAlignment = .center
        $0.font = .smallFont
        $0.backgroundColor = .newsHabit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 9
    }
    
    let thumbnailView = UIImageView().then {
        $0.backgroundColor = .gray
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        selectionStyle = .none
    }
    
    private func setupHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(isReadView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(categoryLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(thumbnailView)
    }
    
    private func setupLayout() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(thumbnailView.snp.top)
            $0.leading.equalToSuperview().inset(15)
        }
        
        isReadView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(6)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.width.equalTo(50)
            $0.height.equalTo(18)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalTo(thumbnailView.snp.leading).offset(-15)
            $0.bottom.equalTo(thumbnailView.snp.bottom)
        }
        
        thumbnailView.snp.makeConstraints {
            $0.width.height.equalTo(75)
            $0.trailing.equalToSuperview().inset(15)
            $0.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Bind ViewModel
    
    func bindViewModel(_ viewModel: NewsCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        categoryLabel.text = viewModel.category
        viewModel.$isRead
            .receive(on: RunLoop.main)
            .sink { [weak self] isRead in
                self?.isReadView.isHidden = isRead
            }.store(in: &cancellables)
    }
    
}
