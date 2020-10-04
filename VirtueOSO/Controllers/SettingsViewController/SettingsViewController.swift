//
//  SettingsViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/25/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

//MARK: - SettingsViewControllerDelegate
protocol SettingsViewControllerDelegate {
    func settingsViewController(_ settingsViewController: SettingsViewController)
}

//MARK: - SettingsViewController
class SettingsViewController: UIViewController {
    
    //MARK: - Private Properties
    
    private let coordinator: ProfileCoordinator
    
    //MARK: - Public Properties
    
    var subviews: [UIView] = [UIView]() {
        didSet {
            vStackView.removeAllArrangedSubviews()
            vStackView.addArrangedSubviews(subviews)
        }
    }
    
    var _title: String? {
        didSet {
            navigationItem.title = _title
        }
    }
    
    // MARK: - Subviews
    
    private(set) lazy var leftBarButtonItem: UIBarButtonItem? = {
        return UIBarButtonItem(sfSymbol: .arrowLeft, style: .plain, target: self, action: #selector(handleGoBack))
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = ._background
        view.alwaysBounceVertical = true
        view.alwaysBounceHorizontal = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var vStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.axis = .vertical
        view.spacing = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Handlers
    @objc private func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Init
    init(coordinator: ProfileCoordinator, subviews: [UIView]) {
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
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: - Init Subviews
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(vStackView)
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        vStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        vStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        vStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        vStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
}
