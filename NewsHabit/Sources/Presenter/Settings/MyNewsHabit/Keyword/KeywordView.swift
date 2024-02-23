//
//  KeywordView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import Combine
import UIKit

class KeywordView: UIView {
    
    // MARK: - Properties
    
    var delegate: KeywordViewDelegate?
    private var viewModel: KeywordViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    let titleLabel = UILabel().then {
        $0.text = "선택한 키워드와 관련된 기사를 매일 추천해드릴게요"
        $0.textColor = .label
        $0.font = .cellTitleFont
        $0.numberOfLines = 0
    }
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.backgroundColor = .clear
        $0.register(KeywordCell.self, forCellWithReuseIdentifier: KeywordCell.reuseIdentifier)
        if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 20
            layout.invalidateLayout()
        }
    }
    
    let saveButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.attributedTitle = .init("저장", attributes: .init([.font: UIFont.labelFont]))
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
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        collectionView.delegate = self
        collectionView.dataSource = self
        saveButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
    }
    
    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(collectionView)
        addSubview(saveButton)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalToSuperview().inset(30)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(saveButton.snp.top).offset(20)
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(50)
            $0.height.equalTo(44)
        }
    }
    
    @objc private func handleSaveButtonTap() {
        guard let viewModel = viewModel else { return }
        var keywordIndexArray = Array(viewModel.selectedKeywordIndex)
        keywordIndexArray.sort()
        UserDefaultsManager.keywordList = keywordIndexArray
        delegate?.popViewController()
    }
    
    // MARK: - Bind ViewModel
    
    func bindViewModel(_ viewModel: KeywordViewModel) {
        self.viewModel = viewModel
        viewModel.$selectedKeywordIndex
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
}

// MARK: - CollectionView Extension

extension KeywordView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.selectKeyword(at: indexPath)
    }
    
}

extension KeywordView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel().then {
            $0.font = .cellLabelFont
            $0.text = KeywordType.allCases[indexPath.row].toString()
            $0.sizeToFit()
        }
        let size = label.frame.size
        
        return CGSize(width: size.width + 36, height: size.height + 12)
    }
    
}

extension KeywordView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return KeywordType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCell.reuseIdentifier, for: indexPath) as? KeywordCell
        else { return UICollectionViewCell() }
        cell.label.text = KeywordType.allCases[indexPath.row].toString()
        cell.setSelected(viewModel.selectedKeywordIndex.contains(indexPath.row))
        return cell
    }
    
}
