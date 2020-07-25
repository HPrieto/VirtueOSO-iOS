//
//  SettingsViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/25/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

//MARK:- SettingsViewControllerDelegate
protocol SettingsViewControllerDelegate {
    func settingsViewController(_ settingsViewController: SettingsViewController)
}

//MARK:- SettingsViewController
class SettingsViewController: UIViewController {
    
    //MARK:- Private Properties
    private let coordinator: SettingsCoordinator
    
    //MARK:- Public Properties
    
    var subviews: [UIView] = [UIView]() {
        didSet {
            vStackView.removeAllArrangedSubviews()
            vStackView.addArrangedSubviews(subviews)
        }
    }
    
    var _title: String? {
        didSet {
            titleLabel.text = _title
        }
    }
    
    //MARK:- Views
    private lazy var backArrowButton: UIButton = {
        let view = UIButton()
        view.setImage(._backArrow, for: .normal)
        view.tintColor = .black
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(type: .medium, size: .small)
        view.textColor = .black
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var topBorder: Border = {
        let view = Border()
        view.backgroundColor = ._background
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = ._background
        view.alwaysBounceVertical = true
        view.alwaysBounceHorizontal = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.axis = .vertical
        view.spacing = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK:- Init
    init(coordinator: SettingsCoordinator, subviews: [UIView]) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.setSubviews(subviews: subviews)
    }
    
    public func setSubviews(subviews: [UIView]) {
        self.subviews = subviews
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK:- Init Subviews
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(backArrowButton)
        view.addSubview(titleLabel)
        view.addSubview(topBorder)
        view.addSubview(scrollView)
        
        backArrowButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        backArrowButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        backArrowButton.rightAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        backArrowButton.heightAnchor.constraint(equalTo: backArrowButton.widthAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.safeAreaInsets.top + 60).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        topBorder.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        topBorder.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topBorder.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        scrollView.addSubview(vStackView)
        
        scrollView.topAnchor.constraint(equalTo: topBorder.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        vStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        vStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        vStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        
    }
    
    //MARK:- Handlers
    @objc private func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
}
