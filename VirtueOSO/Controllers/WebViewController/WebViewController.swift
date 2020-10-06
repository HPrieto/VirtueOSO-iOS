//
//  WebViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 8/8/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit
import WebKit

var webViewContext = 0

// MARK: - WebViewController
class WebViewController: UIViewController {
    
    // MARK: - Public Properties
    var urlString: String? {
        didSet {
            loadingBarView.show()
            loadingBarView.setProgress(percent: 10)
            guard let urlString: String = urlString,
                let url = URL(string: urlString) else {
                    return
            }
            
            var urlRequest = URLRequest(url: url)
             urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
            webView.load(urlRequest)
            loadingBarView.setProgress(percent: 40)
        }
    }
    
    // MARK: - Subviews
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(sfSymbol: .arrowLeft, style: .plain, target: self, action: #selector(handleGoBack))
    }()
    
    private(set) lazy var loadingBarView: LoadingBarView = {
        return LoadingBarView()
    }()
    
    @objc private(set) lazy var webView: WKWebView = {
        let view = WKWebView()
        view.backgroundColor = .white
        view.allowsBackForwardNavigationGestures = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Observers
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let _ = change else { return }
        
        if context != &webViewContext, keyPath == #keyPath(webView.estimatedProgress) {
            loadingBarView.setProgress(percent: CGFloat(webView.estimatedProgress))
        }
    }
    
    // MARK: - Handlers
    @objc private func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Utils
    public func load(urlString: String) {
        self.urlString = urlString
    }
    
    private func clean() {
        webView.load(URLRequest(url: URL(string:"about:blank")!))
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("[WebCacheCleaner] Record \(record) deleted")
            }
        }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Observe url loading progress
        // webView.addObserver(self, forKeyPath: #keyPath(webView.estimatedProgress), options: .new, context: &webViewContext)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        clean()
    }
    
    // MARK: - Initialize Subviews
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        view.addSubview(loadingBarView)
        view.addSubview(webView)
        
        loadingBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        loadingBarView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        loadingBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        webView.navigationDelegate = self
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - Init
    init(_ urlString: String) {
        super.init(nibName: nil, bundle: nil)
        self.load(urlString: urlString)
    }
    
    deinit {
        // webView.removeObserver(self, forKeyPath: #keyPath(webView.estimatedProgress), context: &webViewContext)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate, WKUIDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingBarView.setProgress(percent: 100) { [weak self] _ in
            guard let `self` = self else { return }
            self.loadingBarView.setProgress(percent: 100, withDuration: 0.5)
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("WebViewController didFail: \(error)")
        loadingBarView.setProgress(percent: 0)
    }
}
