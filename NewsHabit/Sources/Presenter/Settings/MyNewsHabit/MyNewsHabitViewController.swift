//
//  MyNewsHabitViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/13/24.
//

import UIKit

class MyNewsHabitViewController: BaseViewController<MyNewsHabitView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func setupNavigationBar() {
        setNavigationBarLinkButtonHidden(true)
        setNavigationBarTitle("나의 뉴빗")
    }
    
}
