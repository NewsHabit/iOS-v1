//
//  WebView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/23/24.
//

import UIKit
import WebKit

import Alamofire
import SnapKit
import Then

final class WebView: UIView, BaseViewProtocol {
    
    private var progressObserver: NSKeyValueObservation?
    
    // MARK: - UI Components
    
    private let webView: WKWebView
    
    private let progressView = UIProgressView().then {
        $0.progressViewStyle = .bar
        $0.tintColor = .label
        $0.sizeToFit()
    }
    
    private let errorView = ErrorView().then {
        $0.isHidden = true
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        webView = WKWebView(frame: .zero, configuration: config)
        
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
    
    // MARK: - BaseViewProtocol
    
    func setupProperty() {
        webView.navigationDelegate = self
        
        progressObserver = webView.observe(\.estimatedProgress, options: .new) { [weak self] webView, _ in
            self?.progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    func setupHierarchy() {
        addSubview(webView)
        addSubview(progressView)
        addSubview(errorView)
    }
    
    func setupLayout() {
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        progressView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        errorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func load(_ url: URL?) {
        guard let url = url else { return }
        webView.load(URLRequest(url: url))
    }
    
}

extension WebView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // 로딩 시작 시 프로그레스 바를 보여주고 진행률 초기화
        progressView.isHidden = false
        progressView.setProgress(0.0, animated: false)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(1.0, animated: true)
        // 약간의 딜레이 후 프로그레스 바를 숨김
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.progressView.isHidden = true
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // "새 창으로 열기" 링크 WebView 내에서 열기
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        decisionHandler(.allow)
    }
    
}
