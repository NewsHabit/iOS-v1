//
//  MyNewsHabitView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import Combine
import UIKit

import SnapKit
import Then

class MyNewsHabitView: UIView {
    
    // MARK: - Properties
    
    var viewModel: MyNewsHabitViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - UI Components
    
    let tableView = UITableView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Bind ViewModel
    
    func bindViewModel(_ viewModel: MyNewsHabitViewModel) {
        self.viewModel = viewModel
        viewModel.transform(input: viewModel.input.eraseToAnyPublisher())
            .receive(on: RunLoop.main)
            .sink { [weak self] event in
                switch event {
                case .updateMyNewsHabitItems:
                    self?.tableView.reloadData()
                }
            }.store(in: &cancellables)
    }
    
}
