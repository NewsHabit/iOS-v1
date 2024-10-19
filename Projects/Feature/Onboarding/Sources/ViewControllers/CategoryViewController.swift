//
//  CategoryViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/19/24.
//

import UIKit

import Shared

public final class CategoryViewController: ViewController<CategoryView> {
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNormalNavigationBar(rightTitle: "다음")
    }
}
