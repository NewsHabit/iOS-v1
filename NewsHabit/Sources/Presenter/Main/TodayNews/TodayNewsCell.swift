//
//  TodayNewsCell.swift
//  NewsHabit
//
//  Created by jiyeon on 2/27/24.
//

import Combine
import UIKit

import Alamofire
import SnapKit
import Then

class TodayNewsCell: UITableViewCell, BaseViewProtocol {
    
    static let reuseIdentifier = "TodayNewsCell"
    var viewModel: TodayNewsCellViewModel?
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
        $0.numberOfLines = 1
        $0.lineBreakMode = .byTruncatingTail
    }
    
    let descriptionLabel = UILabel().then {
        $0.textColor = .newsHabitGray
        $0.font = .cellLabelFont
        $0.numberOfLines = 3
        $0.lineBreakMode = .byTruncatingTail
    }
    
    let categoryLabel = UILabel().then {
        $0.textColor = .background
        $0.textAlignment = .center
        $0.font = .smallFont
        $0.backgroundColor = .newsHabit
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 9
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
        categoryLabel.text = nil
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
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(isReadView)
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
    
    func bindViewModel(_ viewModel: TodayNewsCellViewModel) {
        self.viewModel = viewModel
        // 초기 데이터 설정
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        loadImage(from: viewModel.imageLink)
        isReadView.isHidden = viewModel.isRead
        categoryLabel.text = Category.fromAPIString(viewModel.category)
        
        viewModel.$isRead
            .receive(on: RunLoop.main)
            .sink { [weak self] isRead in
                self?.isReadView.isHidden = isRead
            }.store(in: &cancellables)
    }
    
    // MARK: - Load Image
    
    private func loadImage(from urlString: String?) {
        guard let urlString = urlString else { return }
        
        APIManager.shared.fetchImageData(from: urlString) { [weak self] result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.thumbnailView.image = image
                }
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
    }

}
