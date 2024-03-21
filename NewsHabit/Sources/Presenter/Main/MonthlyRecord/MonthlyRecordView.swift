//
//  MonthlyRecordView.swift
//  NewsHabit
//
//  Created by jiyeon on 3/13/24.
//

import UIKit

import SnapKit
import Then

class MonthlyRecordView: UIView {
    
    var daysInCurrentMonth: Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: Date())!
        return range.count
    }
    
    var firstWeekdayInCurrentMonth: Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: Date())
        let startOfMonth = calendar.date(from: components)!
        return calendar.component(.weekday, from: startOfMonth)
    }
    
    // MARK: - UI Components
    
    let titleLabel = UILabel().then {
        $0.text = Date().toYearMonthString()
        $0.font = .titleFont
        $0.textColor = .label
    }
    
    let numOfMonthlyAllReadLabel = UILabel().then {
        $0.text = "📚 \(UserDefaultsManager.monthlyAllRead.count)"
        $0.font = .cellTitleFont
        $0.textColor = .label
    }
    
    let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        $0.backgroundColor = .clear
        $0.register(MonthlyRecordCell.self, forCellWithReuseIdentifier: MonthlyRecordCell.reuseIdentifier)
        if let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 20
            layout.invalidateLayout()
        }
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
    }
    
    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(numOfMonthlyAllReadLabel)
        addSubview(collectionView)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(50)
        }
        
        numOfMonthlyAllReadLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(50)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(50)
            $0.bottom.equalToSuperview()
        }
    }
    
    func update() {
        numOfMonthlyAllReadLabel.text = "📚 \(UserDefaultsManager.monthlyAllRead.count)"
        collectionView.reloadData()
    }
    
}

// MARK: - CollectionView Extension

extension MonthlyRecordView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let width = (collectionViewWidth - 60) / 7
        return CGSize(width: width, height: width)
    }
    
}

extension MonthlyRecordView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 현재 달의 일수 + 시작 요일의 오프셋
        return daysInCurrentMonth + firstWeekdayInCurrentMonth - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthlyRecordCell.reuseIdentifier, for: indexPath)
                as? MonthlyRecordCell else { return UICollectionViewCell() }
        let dayIndex = indexPath.row - (firstWeekdayInCurrentMonth - 1)
        let dayString = String(format: "%02d", dayIndex + 1)
        if dayIndex >= 0 {
            cell.setRead(isDayRead(dayString), isToday(dayString), dayString)
        } else {
            cell.setEmpty()
        }
        return cell
    }
    
    private func isDayRead(_ dayString: String) -> Bool {
        return UserDefaultsManager.monthlyAllRead.contains(dayString)
    }
    
    private func isToday(_ dayString: String) -> Bool {
        return Date().toDayString() == dayString
    }
    
}
