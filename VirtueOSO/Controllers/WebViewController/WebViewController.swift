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
    
    enum ViewState {
        case loading
        case normal
        case error(message: String)
    }
    
    enum Strings: String {
        case errorMessage = "Our apologies! We're experiencing a technical problem, and our team is investigating"
    }
    
    // MARK: - Public Properties
    
    var urlString: String?
    
    var _state: ViewState = .loading {
        didSet {
            switch _state {
            case .loading:
                loadingBarView.show()
            case .normal:
                loadingBarView.hide()
            case .error(let message):
                loadingBarView.show()
                alertController.message = message
                present(alertController, animated: true, completion: nil)
            }
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
        view.backgroundColor = .clear
        view.allowsBackForwardNavigationGestures = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.navigationDelegate = self
        return view
    }()
    
    private(set) lazy var alertController: UIAlertController = {
        let controller = UIAlertController(
            title: "Error",
            message: Strings.errorMessage.rawValue,
            preferredStyle: .alert
        )
        controller.addAction(
            UIAlertAction(
                title: "OK",
                style: .cancel,
                handler: nil
            )
        )
        return controller
    }()
    
    // MARK: - Observers
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let _ = change else { return }
        
        if context != &webViewContext, keyPath == #keyPath(webView.estimatedProgress) {
            print(webView.estimatedProgress)
            loadingBarView.setProgress(percent: CGFloat(webView.estimatedProgress))
        }
    }
    
    // MARK: - Handlers
    
    @objc private func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Utils
    
    public func loadWebpage() {
        _state = .loading
        loadingBarView.setProgress(percent: 10)
        guard let urlString: String = urlString,
            let url = URL(string: urlString) else {
                return
        }
        
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        loadingBarView.setProgress(percent: 40)
    }
    
    private func clean() {
        _state = .normal
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
        loadWebpage()
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
        
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // MARK: - Init
    init(_ urlString: String) {
        super.init(nibName: nil, bundle: nil)
        self.urlString = urlString
        loadWebpage()
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
        _state = .error(message: Strings.errorMessage.rawValue)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        _state = .error(message: error.localizedDescription)
    }
}
