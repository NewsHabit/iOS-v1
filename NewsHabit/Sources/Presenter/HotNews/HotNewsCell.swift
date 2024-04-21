//
//  HotNewsCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/19/24.
//

import Combine
import UIKit

import Kingfisher
import SnapKit
import Then

final class HotNewsCell: UITableViewCell, BaseViewProtocol {
    
    static let reuseIdentifier = "HotNewsCell"
    private var viewModel: HotNewsCellViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    let titleLabel = UILabel().then {
        $0.textColor = .label
        $0.font = .cellTitleFont
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
    
    let descriptionLabel = UILabel().then {
        $0.textColor = .newsHabitGray
        $0.font = .cellLabelFont
        $0.numberOfLines = 3
        $0.lineBreakMode = .byTruncatingTail
    }
    
    let thumbnailView = UIImageView().then {
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
        thumbnailView.image = nil
        
        // Combine 구독 취소
        cancellables.removeAll()
    }
    
    // MARK: - Setup Methods
    
    func setupProperty() {
        backgroundColor = .background
        selectionStyle = .none
    }
    
    func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(thumbnailView)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailView.snp.top)
            $0.leading.equalToSuperview().inset(15)
            $0.trailing.equalTo(thumbnailView.snp.leading).offset(-15)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
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
    
    func bindViewModel(_ viewModel: HotNewsCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        loadImage(from: viewModel.imageLink)
    }
    
    // MARK: - Load Image
    
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString,
              let url = URL(string: urlString) else { return }
        thumbnailView.kf.setImage(with: url)
    }

}
