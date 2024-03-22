//
//  BaseProtocol.swift
//  NewsHabit
//
//  Created by jiyeon on 3/22/24.
//

import Foundation

protocol BaseViewControllerProtocol {
    func setupNavigationBar()
}

protocol BaseViewProtocol {
    func setupProperty()
    func setupHierarchy()
    func setupLayout()
}
