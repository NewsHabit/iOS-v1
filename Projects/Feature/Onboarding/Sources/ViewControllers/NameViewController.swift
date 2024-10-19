//
//  NameViewController.swift
//  FeatureOnboarding
//
//  Created by 지연 on 10/19/24.
//

import UIKit

import Shared

public final class NameViewController: ViewController<NameView> {
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNormalNavigationBar(rightTitle: "다음", isBackButtonHidden: true)
    }
}
