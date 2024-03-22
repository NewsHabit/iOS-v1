//
//  TodayNewsCountViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import UIKit

protocol TodayNewsCountViewDelegate {
    func popViewController()
}

final class TodayNewsCountViewController: BottomSheetController<TodayNewsCountView> {
    
    var delegate: MyNewsHabitViewDelegate?
    private let viewModel = TodayNewsCountViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetView.delegate = self
        sheetView.bindViewModel(viewModel)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.updateMyNewsHabitSettings()
    }
    
}

extension TodayNewsCountViewController: TodayNewsCountViewDelegate {
    
    func popViewController() {
        super.hideBottomSheets()
    }
    
}
