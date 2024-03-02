//
//  NotificationView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/24/24.
//

import Combine
import UIKit

class NotificationView: UIView {
    
    private var viewModel: NotificationViewModel?
    private var cancellables = Set<AnyCancellable>()
    private let feedbackGenerator = UISelectionFeedbackGenerator()

    // MARK: - UI Components
    
    let tableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.register(NotificationSwitchCell.self, forCellReuseIdentifier: NotificationSwitchCell.reuseIdentifier)
        $0.register(NotificationTimeCell.self, forCellReuseIdentifier: NotificationTimeCell.reuseIdentifier)
    }
    
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.isHidden = true
    }
    
    let datePicker = UIDatePicker().then {
        $0.datePickerMode = .time
        $0.timeZone = .current
        $0.preferredDatePickerStyle = .wheels
    }
    
    let saveButton = UIButton().then {
        $0.configuration = .plain()
        $0.configuration?.attributedTitle = .init("저장", attributes: .init([.font: UIFont.labelFont]))
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
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        tableView.delegate = self
        tableView.dataSource = self
        feedbackGenerator.prepare()
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        saveButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
    }
    
    private func setupHierarchy() {
        addSubview(tableView)
        addSubview(stackView)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(saveButton)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(stackView.snp.top)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(30)
            $0.height.equalTo(250)
        }
        
        saveButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
    }
    
    // MARK: - Bind ViewModel
    
    func bindViewModel(_ viewModel: NotificationViewModel) {
        self.viewModel = viewModel
        viewModel.transform(input: viewModel.input.eraseToAnyPublisher())
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                switch event {
                case .updateNotification:
                    if self?.stackView.isHidden == false {
                        self?.stackView.isHidden = true
                    }
                case .updateNotificationTime:
                    self?.tableView.reloadData()
                }
            }.store(in: &cancellables)
    }
    
    // MARK: - Action Functions
    
    @objc func datePickerValueChanged() {
        feedbackGenerator.selectionChanged()
        feedbackGenerator.prepare() // 다음 진동을 위해 다시 준비
    }
    
    @objc func handleSaveButtonTap() {
        stackView.isHidden = true
        datePicker.date = datePicker.date
        viewModel?.input.send(.setNotificationTime(datePicker.date))
    }

}

extension NotificationView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 && stackView.isHidden {
            stackView.isHidden = false
        }
    }
    
}

extension NotificationView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserDefaultsManager.isNotificationOn ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationSwitchCell.reuseIdentifier)
                    as? NotificationSwitchCell else { return UITableViewCell() }
            cell.titleLabel.text = "알림"
            cell.switchControl.isOn = UserDefaultsManager.isNotificationOn
            cell.switchControl.addTarget(self, action: #selector(handleSwitchControlTap), for: .touchUpInside)
            return cell
        case 1 where UserDefaultsManager.isNotificationOn:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTimeCell.reuseIdentifier)
                    as? NotificationTimeCell else { return UITableViewCell() }
            cell.titleLabel.text = "시간"
            cell.timeLabel.text = UserDefaultsManager.notificationTime
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    @objc private func handleSwitchControlTap(_ switchControl: UISwitch) {
        viewModel?.input.send(.setNotification(switchControl.isOn))

        tableView.beginUpdates()
        if switchControl.isOn {
            tableView.insertRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        } else {
            tableView.deleteRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        }
        tableView.endUpdates()
    }

}
