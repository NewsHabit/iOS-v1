//
//  KeywordView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/5/24.
//

import Combine
import UIKit

class KeywordView: BaseView {
    
    // MARK: - Properties
    
    var delegate: KeywordViewDelegate?
    var viewModel: KeywordViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    let guideLabel = UILabel().then {
        $0.text = "추천받고 싶은 뉴스 키워드를 골라주세요"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .label
    }
    
    let descriptionLabel = UILabel().then {
        $0.text = "최대 3개까지 선택할 수 있어요"
        $0.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = .gray
    }
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.register(KeywordCell.self, forCellWithReuseIdentifier: KeywordCell.reuseIdentifier)
        if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 20
            layout.invalidateLayout()
        }
    }
    
    let saveButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.title = "저장"
        $0.layer.cornerRadius = 8
        $0.tintColor = .white
        $0.backgroundColor = UIColor(red: 166/255, green: 207/255, blue: 178/255, alpha: 1) // 📌
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        saveButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    override func setupLayout() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        addSubview(guideLabel)
        addSubview(descriptionLabel)
        addSubview(collectionView)
        addSubview(saveButton)
        
        guideLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(23)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(23)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(saveButton.snp.top).offset(30)
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(48)
        }
    }
    
    @objc private func handleSaveButtonTap() {
        guard let viewModel = viewModel else { return }
        var keywordIndexArray = Array(viewModel.selectedKeywordIndex)
        keywordIndexArray.sort()
        Settings.keyword = keywordIndexArray
        delegate?.popViewController()
    }
    
}

// MARK: - ViewModel Binding

extension KeywordView {
    
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
            $0.font = .systemFont(ofSize: 14)
            $0.text = Keyword.allCases[indexPath.row].toString()
            $0.sizeToFit()
        }
        let size = label.frame.size
        
        return CGSize(width: size.width + 40, height: size.height + 14)
    }
    
}

extension KeywordView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Keyword.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeywordCell.reuseIdentifier, for: indexPath) as? KeywordCell
        else { return UICollectionViewCell() }
        cell.label.text = Keyword.allCases[indexPath.row].toString()
        if viewModel.selectedKeywordIndex.contains(indexPath.row) {
            cell.backgroundColor = UIColor(red: 166/255, green: 207/255, blue: 178/255, alpha: 1) // 📌
        } else {
            cell.backgroundColor = .systemGray4
        }
        return cell
    }
    
}
