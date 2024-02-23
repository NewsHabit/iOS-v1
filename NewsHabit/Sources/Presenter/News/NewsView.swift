//
//  NewsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/23/24.
//

import UIKit
import WebKit

import SnapKit

class NewsView: UIView {
    
    // MARK: - UI Components
    
    let webView = WKWebView()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        webView.stopLoading()
    }

    // MARK: - Setup Methods
    
    private func setupHierarchy() {
        addSubview(webView)
    }
    
    private func setupLayout() {
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Load Link
    
    func loadLink(_ newsLink: String?) {
        guard let newsLink = newsLink,
              let url = URL(string: newsLink) else { return }
        webView.load(URLRequest(url: url))
    }
    
}
