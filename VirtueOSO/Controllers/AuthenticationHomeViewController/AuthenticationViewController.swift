//
//  AuthenticationViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class AuthenticationHomeViewController: UIViewController {
    
    lazy var backgroundImageView: UIImageView = {
        //let image = UIImage(named: "concert_bg")!
        let view = UIImageView()
        //view.image = image
        view.backgroundColor = ._primary
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var iconImageView: UIImageView = {
        let image = UIImage(named: "music_tickets")!.withRenderingMode(.alwaysTemplate)
        let view = UIImageView()
        view.image = image
        view.tintColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleTextView: TextView = {
        let view = TextView()
        view.font = UIFont(type: .medium, size: .title2)
        view.textColor = .white
        view.text = "Welcome to Virtuoso."
        return view
    }()
    
    lazy var googleButton: Button = {
        let view = Button("Continue with Google")
        view.backgroundColor = .white
        view._font = UIFont(type: .medium, size: .large)
        view._textColor = ._secondary
        view._cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var facebookButton: Button = {
        let view = Button("Continue with Facebook")
        view.backgroundColor = .white
        view._font = UIFont(type: .medium, size: .large)
        view._textColor = ._secondary
        view._cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var createAccountButton: Button = {
        let view = Button("Create an Account")
        view.backgroundColor = .white
        view._font = UIFont(type: .medium, size: .large)
        view._textColor = .white
        view.backgroundColor = ._secondary
        view._borderColor = .white
        view._borderWidth = 1
        view._cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var optionsTextView: TextView = {
        let view = TextView()
        view.textColor = .white
        view.backgroundColor = .clear
        view.font = UIFont(type: .medium, size: .regular)
        view.text = "More options"
        return view
    }()
    
    lazy var disclaimerTextView: TextView = {
        let view = TextView()
        view.textColor = .white
        view.font = UIFont(type: .medium, size: .regular)
        view.text = """
        By signing up, I agree to Virutuoso's Terms of Service, Non-Discrimination Policy, Payments Terms of Service, and Host Guarantee Terms.
        """
        return view
    }()
    
    lazy var signinBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem(title: "Log in", style: .plain, target: nil, action: nil)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    private func initializeSubviews() {
        view.backgroundColor = ._secondary
        
        view.addSubview(iconImageView)
        view.addSubview(titleTextView)
        view.addSubview(googleButton)
        view.addSubview(facebookButton)
        view.addSubview(createAccountButton)
        view.addSubview(optionsTextView)
        view.addSubview(disclaimerTextView)
        
        iconImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top + 130).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor).isActive = true
        iconImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        titleTextView.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 20).isActive = true
        titleTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        titleTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        googleButton.topAnchor.constraint(equalTo: titleTextView.bottomAnchor, constant: 50).isActive = true
        googleButton.widthAnchor.constraint(equalTo: titleTextView.widthAnchor).isActive = true
        googleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        googleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        facebookButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 20).isActive = true
        facebookButton.widthAnchor.constraint(equalTo: googleButton.widthAnchor).isActive = true
        facebookButton.centerXAnchor.constraint(equalTo: googleButton.centerXAnchor).isActive = true
        facebookButton.heightAnchor.constraint(equalTo: googleButton.heightAnchor).isActive = true
        
        createAccountButton.topAnchor.constraint(equalTo: facebookButton.bottomAnchor, constant: 20).isActive = true
        createAccountButton.widthAnchor.constraint(equalTo: googleButton.widthAnchor).isActive = true
        createAccountButton.centerXAnchor.constraint(equalTo: googleButton.centerXAnchor).isActive = true
        createAccountButton.heightAnchor.constraint(equalTo: googleButton.heightAnchor).isActive = true
        
        optionsTextView.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 20).isActive = true
        optionsTextView.widthAnchor.constraint(equalTo: createAccountButton.widthAnchor).isActive = true
        optionsTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        disclaimerTextView.topAnchor.constraint(equalTo: optionsTextView.bottomAnchor, constant: 50).isActive = true
        disclaimerTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        disclaimerTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        navigationItem.rightBarButtonItem = signinBarButton
    }
    
}
