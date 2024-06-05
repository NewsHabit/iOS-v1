//
//  NotificationView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/24/24.
//

import Combine
import UIKit

protocol NotificationViewDelegate: AnyObject {
    func showNotificationPermissionAlert()
}

final class NotificationView: UIView, BaseViewProtocol {

    weak var delegate: NotificationViewDelegate?
    private var viewModel: NotificationViewModel?
    private var cancellables = Set<AnyCancellable>()
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    private let heightForRow = 44.0
    
    // MARK: - UI Components
    
    private lazy var switchView = NotificationSwitchView().then {
        $0.delegate = self
        $0.setSwifthControlAction(#selector(handleSwitchControlTap))
        $0.configure(with: UserDefaultsManager.isNotificationOn)
    }
    
    private let timeView = NotificationTimeView().then {
        $0.isHidden = !UserDefaultsManager.isNotificationOn
        $0.configure(with: UserDefaultsManager.notificationTime)
        $0.isUserInteractionEnabled = true
    }
    
    private let datePickerView = UIStackView().then {
        $0.axis = .vertical
        $0.isHidden = true
    }
    
    private let datePicker = UIDatePicker().then {
        $0.datePickerMode = .time
        $0.locale = Locale(identifier: "en_US_POSIX") // 12시간제 AM/PM 표기 로케일
        $0.timeZone = TimeZone(identifier: "Asia/Seoul")
        $0.preferredDatePickerStyle = .wheels
    }
    
    private let saveButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.attributedTitle = .init("저장", attributes: .init([.font: UIFont.body]))
        $0.tintColor = .white
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    
    // MARK: - Inititlizer
    
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
        feedbackGenerator.prepare()
        timeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTimeViewTap)))
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        saveButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleTimeViewTap() {
        datePickerView.isHidden = false
    }
    
    @objc private func datePickerValueChanged() {
        feedbackGenerator.selectionChanged()
        feedbackGenerator.prepare() // 다음 진동을 위해 다시 준비
    }
    
    @objc private func handleSaveButtonTap() {
        datePickerView.isHidden = true
        timeView.configure(with: datePicker.date.toSimpleTimeString())
        viewModel?.input.send(.setNotificationTime(datePicker.date))
    }
    
    func setupHierarchy() {
        addSubview(switchView)
        addSubview(timeView)
        addSubview(datePickerView)
        datePickerView.addArrangedSubview(datePicker)
        datePickerView.addArrangedSubview(saveButton)
    }
    
    func setupLayout() {
        switchView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(heightForRow)
        }
        
        timeView.snp.makeConstraints {
            $0.top.equalTo(switchView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(heightForRow)
        }
        
        datePickerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(250)
        }
        
        saveButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }
    
    @objc func handleSwitchControlTap(_ switchControl: UISwitch) {
        viewModel?.input.send(.setNotificationStatus(switchControl.isOn))
    }
    
    // MARK: - Bind
    
    func bind(with viewModel: NotificationViewModel) {
        self.viewModel = viewModel
        
        viewModel.transform(input: viewModel.input.eraseToAnyPublisher())
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .permissionDenied:
                    handlePermissionDenied()
                case let .updateNotificationStatus(isOn):
                    handleUpdateNotificationStatus(isOn)
                }
            }.store(in: &cancellables)
    }
    
    private func handlePermissionDenied() {
        switchView.configure(with: false)
        delegate?.showNotificationPermissionAlert()
    }
    
    private func handleUpdateNotificationStatus(_ isOn: Bool) {
        switchView.configure(with: isOn)
        timeView.isHidden = !isOn
        datePickerView.isHidden = true
    }
    
    /// 외부(설정 앱)에서 알림 상태가 바뀌었을 때 호출되는 함수
    func updateNotificationStatus() {
        viewModel?.input.send(.updateNotificationStatus)
    }
    
}
