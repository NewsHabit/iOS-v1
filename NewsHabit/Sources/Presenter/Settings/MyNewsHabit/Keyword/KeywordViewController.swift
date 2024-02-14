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
    
    // MARK: - Properties
    
    var delegate: MyNewsHabitViewDelegate?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sheetView.delegate = self
        sheetView.bindViewModel(KeywordViewModel())
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
