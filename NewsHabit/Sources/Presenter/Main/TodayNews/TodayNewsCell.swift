//
//  TodayNewsCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/27/24.
//

import Combine
import UIKit

import Kingfisher
import SnapKit
import Then

final class TodayNewsCell: UITableViewCell, BaseViewProtocol {
    
    static let reuseIdentifier = "TodayNewsCell"
    private var viewModel: TodayNewsCellViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    private let stackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
    }
    
    private let readStateView = UIView().then {
        $0.backgroundColor = .newsHabitAccent
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 3
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .bodySB
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
    
    private let descriptionLabel = UILabel().then {
        $0.textColor = .newsHabitGray
        $0.font = .caption
        $0.numberOfLines = 3
        $0.lineBreakMode = .byTruncatingTail
    }
    
    private let categoryLabel = UILabel().then {
        $0.textColor = .background
        $0.textAlignment = .center
        $0.font = .footnote
        $0.backgroundColor = .newsHabit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 9
    }
    
    private let thumbnailView = UIImageView().then {
        $0.backgroundColor = .gray
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        descriptionLabel.text = nil
        categoryLabel.text = nil
        thumbnailView.image = nil
        // Combine 구독 취소
        cancellables.removeAll()
    }
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        backgroundColor = .background
        selectionStyle = .none
    }
    
    func setupHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(readStateView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(categoryLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(thumbnailView)
    }
    
    func setupLayout() {
        stackView.snp.makeConstraints {
            $0.top.equalTo(thumbnailView.snp.top)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalTo(thumbnailView.snp.leading).offset(-15)
        }
        
        readStateView.snp.makeConstraints {
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
    
    // MARK: - Bind
    
    func bindViewModel(_ viewModel: TodayNewsCellViewModel) {
        self.viewModel = viewModel
        
        readStateView.isHidden = viewModel.isRead
        titleLabel.text = viewModel.title
        categoryLabel.text = Category.fromAPIString(viewModel.category)
        descriptionLabel.text = viewModel.description
        loadImage(from: viewModel.imageLink)
        
        viewModel.$isRead
            .receive(on: RunLoop.main)
            .sink { [weak self] isRead in
                self?.readStateView.isHidden = isRead
            }.store(in: &cancellables)
    }
    
    // MARK: - Load Image
    
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString,
                let url = URL(string: urlString) else { return }
        thumbnailView.kf.setImage(with: url)
    }

}
