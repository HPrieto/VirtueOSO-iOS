//
//  AuthenticationViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/10/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    lazy var backgroundImageView: UIImageView = {
        //let image = UIImage(named: "concert_bg")!
        let view = UIImageView()
        //view.image = image
        view.backgroundColor = ._secondary
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleView: TitleView = {
        let view = TitleView(
            title: "VirtueOSO"
        )
        return view
    }()
    
    lazy var emailTextField: TextFieldView = {
        let view = TextFieldView(
            label: "EMAIL ADDRESS"
        )
        view._color = .white
        view._tintColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    private func initializeSubviews() {
        view.backgroundColor = ._primary
        
        view.addSubview(titleView)
        view.addSubview(emailTextField)
        
        titleView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top).isActive = true
        titleView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
    }
    
}
