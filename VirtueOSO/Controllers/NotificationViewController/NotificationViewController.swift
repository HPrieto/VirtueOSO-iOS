//
//  NotificationViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/12/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

protocol NotificationViewControllerDelegate {
    func notificationViewController(_ controller: NotificationViewController, primaryButtonTapped: Int)
    func notificationViewController(_ controller: NotificationViewController, secondaryButtonTapped: Int)
}

class NotificationViewController: UIViewController {
    
    var delegate: NotificationViewControllerDelegate?
    
    var tag: Int = 0
    
    var _title: String = "" {
        didSet {
            titleView._title = _title
        }
    }
    
    var _subtitle: String = "" {
        didSet {
            titleView._subtitle = _subtitle
        }
    }
    
    var _primaryButtonText: String = "" {
        didSet {
            primaryButton.setTitle(_primaryButtonText, for: .normal)
        }
    }
    
    var _secondaryButtonText: String = "" {
        didSet {
            secondaryButton.setTitle(_secondaryButtonText, for: .normal)
        }
    }
    
    lazy var imageView: UIImageView = {
        let image = UIImage(named: "notification-bell")!.withRenderingMode(.alwaysTemplate)
        let view = UIImageView()
        view.tintColor = ._secondary
        view.image = image
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleView: TitleView = {
        let view = TitleView()
        return view
    }()
    
    lazy var primaryButton: Button = {
        let view = Button()
        view.backgroundColor = ._secondary
        view._textColor = .white
        view._cornerRadius = 8
        view.addTarget(self, action: #selector(handlePrimaryButtonTapped), for: .touchUpInside)
        return view
    }()
    
    @objc func handlePrimaryButtonTapped() {
        delegate?.notificationViewController(self, primaryButtonTapped: self.tag)
    }
    
    lazy var secondaryButton: Button = {
        let view = Button()
        view.backgroundColor = .white
        view._borderWidth = 2
        view._borderColor = ._secondary
        view._textColor = ._secondary
        view._cornerRadius = 8
        view.addTarget(self, action: #selector(handleSecondaryButtonTapped), for: .touchUpInside)
        return view
    }()
    
    @objc func handleSecondaryButtonTapped() {
        delegate?.notificationViewController(self, secondaryButtonTapped: self.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    private func initializeSubviews() {
        view.backgroundColor = self._darkModeEnabled ? .black : .white
        navigationController?.navigationBar.barStyle = .default
        
        view.addSubview(imageView)
        view.addSubview(titleView)
        view.addSubview(primaryButton)
        view.addSubview(secondaryButton)
        
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top + Margins.top.rawValue).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        titleView.titleTextView._padding = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        titleView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        titleView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: Margins.width.rawValue).isActive = true
        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        primaryButton.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20).isActive = true
        primaryButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true

        secondaryButton.leftAnchor.constraint(equalTo: primaryButton.leftAnchor).isActive = true
        secondaryButton.topAnchor.constraint(equalTo: primaryButton.bottomAnchor, constant: 20).isActive = true
        
        titleView._title = "Turn on Notifications?"
        titleView._subtitle = "We can let you know when someone messages you, or notify you about other important account activity"
        primaryButton._title = "Yes, notify me"
        secondaryButton._title = "Skip"
    }
    
}
