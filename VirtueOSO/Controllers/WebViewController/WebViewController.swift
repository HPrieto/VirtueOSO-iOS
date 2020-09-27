//
//  WebViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 8/8/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit
import WebKit

// MARK: - WebViewController
class WebViewController: UIViewController {
    
    // MARK: - Public Properties
    var urlString: String? {
        didSet {
            guard let urlString: String = urlString,
                let url = URL(string: urlString) else {
                    return
            }
            
            var urlRequest = URLRequest(url: url)
             urlRequest.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
            webView.load(urlRequest)
        }
    }
    
    // MARK: - Subviews
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(sfSymbol: .arrowLeft, style: .plain, target: self, action: #selector(handleGoBack))
    }()
    
    private lazy var loadingBarView: LoadingBarView = {
        let view = LoadingBarView()
        return view
    }()
    
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.allowsBackForwardNavigationGestures = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        clean()
    }
    
    // MARK: - Initialize Subviews
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        view.addSubview(loadingBarView)
        view.addSubview(webView)
        
        loadingBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        loadingBarView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        loadingBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("WebViewController didFail: \(error)")
    }
}
