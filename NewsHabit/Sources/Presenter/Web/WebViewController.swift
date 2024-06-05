//
//  WebViewController.swift
//  NewsHabit
//
//  Created by jiyeon on 2/23/24.
//

import UIKit

final class WebViewController: BaseViewController<WebView> {
    
    var urlString: String? {
        didSet {
            updateURLFromString()
        }
    }
    
    private var url: URL?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        if urlString == nil {
            urlString = "https://newshabit.org"
        }
    }
    
    // MARK: - BaseViewControllerProtocol
    
    func setupNavigationBar() {
        setNavigationBarShareButtonAction(#selector(handleShareButtonTap))
    }
    
    @objc private func handleShareButtonTap() {
        guard let url = url else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    private func updateURLFromString() {
        if let urlString = urlString {
            url = URL(string: urlString)
        }
        contentView.load(url)
    }
    
    func disableShareButton() {
        setNavigationBarShareButtonHidden(true)
    }
    
}
