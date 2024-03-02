//
//  KeywordViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/14/24.
//

import UIKit

protocol KeywordViewDelegate {
    func popViewController()
}

class KeywordViewController: BottomSheetController<KeywordView> {
    
    var delegate: MyNewsHabitViewDelegate?
    private let viewModel = KeywordViewModel()
    
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

extension KeywordViewController: KeywordViewDelegate {
    
    func popViewController() {
        super.hideBottomSheets()
    }
    
}
