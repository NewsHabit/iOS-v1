//
//  NotificationView.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import UIKit

import Shared
import SnapKit

public final class NotificationView: UIView {
    // MARK: - Components
    
    private lazy var isEnableLabel = createLabel(with: "알림 허용")
    
    let switchControl = {
        let view = UISwitch()
        view.onTintColor = Colors.primary
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var timeLabel = createLabel(with: "알림 시간")
    
    let datePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "ko_KR")
        picker.minuteInterval = 15
        picker.preferredDatePickerStyle = .wheels
        picker.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        return picker
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(isEnableLabel)
        isEnableLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(switchControl)
        switchControl.snp.makeConstraints { make in
            make.centerY.equalTo(isEnableLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(isEnableLabel.snp.bottom).offset(28)
            make.leading.equalToSuperview().inset(20)
        }
        
        addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
}

private extension NotificationView {
    func createLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = Fonts.body1
        label.textColor = Colors.gray09
        return label
    }
}
