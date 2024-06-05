//
//  NotificationView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/24/24.
//

import Combine
import UIKit

protocol NotificationViewDelegate: AnyObject {
    func showAlert()
}

final class NotificationView: UIView, BaseViewProtocol {

    weak var delegate: NotificationViewDelegate?
    private var viewModel: NotificationViewModel?
    private var cancellables = Set<AnyCancellable>()
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    private var dataSource: UITableViewDiffableDataSource<NotificationSection, NotificationCell>!
    
    // MARK: - UI Components
    
    private let tableView = UITableView().then {
        $0.backgroundColor = .background
        $0.separatorStyle = .none
        $0.register(NotificationSwitchCell.self, forCellReuseIdentifier: NotificationSwitchCell.reuseIdentifier)
        $0.register(NotificationTimeCell.self, forCellReuseIdentifier: NotificationTimeCell.reuseIdentifier)
    }
    
    private let stackView = UIStackView().then {
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
        setupDiffableDataSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        tableView.delegate = self
        
        feedbackGenerator.prepare()
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        saveButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
    }
    
    @objc func datePickerValueChanged() {
        feedbackGenerator.selectionChanged()
        feedbackGenerator.prepare() // 다음 진동을 위해 다시 준비
    }
    
    @objc func handleSaveButtonTap() {
        stackView.isHidden = true
        datePicker.date = datePicker.date
        viewModel?.input.send(.setNotificationTime(datePicker.date))
    }
    
    func setupHierarchy() {
        addSubview(tableView)
        addSubview(stackView)
        stackView.addArrangedSubview(datePicker)
        stackView.addArrangedSubview(saveButton)
    }
    
    func setupLayout() {
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
    
    private func setupDiffableDataSource() {
        dataSource = UITableViewDiffableDataSource<NotificationSection, NotificationCell>(tableView: tableView) { [weak self] (tableView, indexPath, item) -> UITableViewCell? in
            switch item {
            case let .switchCell(isOn):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationSwitchCell.reuseIdentifier) as? NotificationSwitchCell else { return UITableViewCell() }
                cell.configure(with: isOn)
                cell.switchControl.removeTarget(nil, action: nil, for: .touchUpInside)
                cell.switchControl.addTarget(self, action: #selector(self?.handleSwitchControlTap), for: .touchUpInside)
                return cell
            case let .timeCell(time):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTimeCell.reuseIdentifier) as? NotificationTimeCell else { return UITableViewCell() }
                cell.configure(with: time)
                return cell
            }
        }
        updateDataSource()
    }
    
    @objc private func handleSwitchControlTap(_ switchControl: UISwitch) {
        viewModel?.input.send(.setNotification(switchControl.isOn))
    }
    
    // MARK: - Update Data Source
    
    private func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<NotificationSection, NotificationCell>()
        snapshot.appendSections([.main])
        if UserDefaultsManager.isNotificationOn {
            snapshot.appendItems([.switchCell(UserDefaultsManager.isNotificationOn), .timeCell(UserDefaultsManager.notificationTime)], toSection: .main)
        } else {
            snapshot.appendItems([.switchCell(UserDefaultsManager.isNotificationOn)], toSection: .main)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - Bind
    
    func bindViewModel(_ viewModel: NotificationViewModel) {
        self.viewModel = viewModel
        
        viewModel.transform(input: viewModel.input.eraseToAnyPublisher())
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .permissionDenied:
                    guard let cell = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? NotificationSwitchCell else { return }
                    cell.switchControl.isOn = false
                    delegate?.showAlert()
                case .updateNotification:
                    updateDataSource()
                    if !stackView.isHidden {
                        stackView.isHidden = true
                    }
                }
            }.store(in: &cancellables)
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
