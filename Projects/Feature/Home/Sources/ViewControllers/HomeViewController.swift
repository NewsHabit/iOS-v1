//
//  HomeViewController.swift
//  FeatureHome
//
//  Created by 지연 on 10/20/24.
//

import UIKit

import Shared

public final class HomeViewController: ViewController<HomeView> {
    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupLargeNavigationBar(
            title: "구지옹님의 뉴빗",
            subTitle: "👀 지금까지 38일 완독했어요!"
        )
        setBackgroundColor(Colors.secondaryBackground)
        setTitleColor(UIColor.white)
    }
}
