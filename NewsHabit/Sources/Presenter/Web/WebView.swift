//
//  WebView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/23/24.
//

import UIKit
import WebKit

import SnapKit
import Then

class WebView: UIView {
    
    private var progressObserver: NSKeyValueObservation?
    
    // MARK: - UI Components
    
    let webView = WKWebView()
    
    let progressView = UIProgressView().then {
        $0.progressViewStyle = .bar
        $0.tintColor = .label
        $0.sizeToFit()
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        progressObserver?.invalidate()
        webView.stopLoading()
    }
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        webView.navigationDelegate = self

        progressObserver = webView.observe(\.estimatedProgress, options: .new) { [weak self] webView, _ in
            self?.progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    private func setupHierarchy() {
        addSubview(webView)
        addSubview(progressView)
    }
    
    private func setupLayout() {
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        progressView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Load Link
    
    func loadLink(_ urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        webView.load(URLRequest(url: url))
    }
    
}

extension WebView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 로딩 완료 시 프로그레스 바 숨김
        progressView.isHidden = true
    }

}
