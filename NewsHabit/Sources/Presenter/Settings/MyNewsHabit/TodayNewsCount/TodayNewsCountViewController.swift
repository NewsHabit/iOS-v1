//
//  TodayNewsCountViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import UIKit

final class TodayNewsCountViewController: BottomSheetController<TodayNewsCountView> {
    
    weak var delegate: MyNewsHabitViewDelegate?
    private let viewModel = TodayNewsCountViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetView.delegate = self
        sheetView.bindViewModel(viewModel)
        sheetView.setSubTitle(with: "변경 시 내일부터 적용돼요")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.updateMyNewsHabitSettings()
    }
    
}

extension TodayNewsCountViewController: TodayNewsCountViewDelegate {
    
    func popViewController() {
        hideBottomSheets()
    }
    
}
