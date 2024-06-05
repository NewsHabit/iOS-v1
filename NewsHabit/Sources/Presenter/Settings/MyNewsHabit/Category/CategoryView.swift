//
//  CategoryView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import Combine
import UIKit

protocol CategoryViewDelegate: AnyObject {
    func popViewController()
}

final class CategoryView: UIView, BaseViewProtocol {
    
    weak var delegate: CategoryViewDelegate?
    private var viewModel: CategoryViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    private let titleLabel = UILabel().then {
        $0.text = "선택한 카테고리와 관련된 기사를 매일 추천해드릴게요"
        $0.textColor = .label
        $0.font = .bodySB
        $0.numberOfLines = 0
    }
    
    private let subTitleLabel = UILabel().then {
        $0.textColor = .newsHabitGray
        $0.font = .title3
    }
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.backgroundColor = .background
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 20
            layout.invalidateLayout()
        }
    }
    
    private let saveButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.attributedTitle = .init("저장", attributes: .init([.font: UIFont.body]))
        $0.tintColor = .white
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        collectionView.delegate = self
        collectionView.dataSource = self
        saveButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleSaveButtonTap() {
        guard let viewModel = viewModel else { return }
        var categoryIndexArray = Array(viewModel.selectedCategoryIndex)
        categoryIndexArray.sort()
        UserDefaultsManager.categoryList = categoryIndexArray
        delegate?.popViewController()
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        addSubview(collectionView)
        addSubview(saveButton)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalToSuperview().inset(30)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(saveButton.snp.top).offset(20)
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(50)
            $0.height.equalTo(44)
        }
    }
    
    func setSubTitle(with text: String) {
        subTitleLabel.text = text
    }
    
    func setSaveButtonHidden() {
        saveButton.isHidden = true
    }
    
    // MARK: - Bind
    
    func bind(with viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        
        viewModel.$selectedCategoryIndex
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}

// MARK: - CollectionView Extension

extension CategoryView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.selectCategory(at: indexPath)
    }
    
}

extension CategoryView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel().then {
            $0.font = .caption
            $0.text = Category.allCases[indexPath.row].toString()
            $0.sizeToFit()
        }
        let size = label.frame.size
        
        return CGSize(width: size.width + 36, height: size.height + 12)
    }
    
}

extension CategoryView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell
        else { return UICollectionViewCell() }
        cell.configure(with: Category.allCases[indexPath.row].toString())
        cell.setSelected(viewModel.selectedCategoryIndex.contains(indexPath.row))
        return cell
    }
    
}
