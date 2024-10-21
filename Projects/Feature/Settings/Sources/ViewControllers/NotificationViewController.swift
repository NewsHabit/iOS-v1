//
//  NotificationViewController.swift
//  FeatureSettings
//
//  Created by 지연 on 10/21/24.
//

import UIKit

import Shared

public final class NotificationViewController: ViewController<NotificationView> {
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNormalNavigationBar(title: "알림")
    }
}
