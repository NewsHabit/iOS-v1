//
//  NewsView.swift
//  NewsHabit
//
//  Created by jiyeon on 2/23/24.
//

import UIKit
import WebKit

import SnapKit
import Then

class NewsView: UIView {
    
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
        webView.stopLoading()
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    // MARK: - Setup Methods
    
    private func setupProperty() {
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
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
    
    func loadLink(_ newsLink: String?) {
        guard let newsLink = newsLink,
              let url = URL(string: newsLink) else { return }
        webView.load(URLRequest(url: url))
    }
    
    // MARK: - KVO
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            // 애니메이션을 사용하여 프로그레스 바 업데이트
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                guard let self = self else { return }
                self.progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
            })
        }
    }
    
    
}

extension NewsView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 로딩 완료 시 프로그레스 바 숨김
        progressView.isHidden = true
    }
    
}
