//
//  EventViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    enum ViewState {
        case normal
        case resume
        case error
    }
    
    // MARK: - Public Properties
    
    var _state: ViewState = .normal {
        didSet {
            switch _state {
            case .normal:
                eventActionView._state = .normal
            case .resume:
                eventActionView._state = .resume
            case .error:
                view.backgroundColor = .red
            }
        }
    }
    
    // MARK: - Private Properties
    
    private var navigationBarHeight: CGFloat {
        let navigationBarHeight: CGFloat = navigationController?.navigationBar.frame.height ?? 0
        return navigationBarHeight
    }
    
    private var eventImageViewHeight: CGFloat {
        return view.frame.height * 0.35
    }
    
    private let leftMarginConstant: CGFloat = 20
    private var rightMarginConstant: CGFloat {
        return -leftMarginConstant
    }
    private let barButtonItemHeightWidth: CGFloat = 35
    private var barButtonItemCornerRadius: CGFloat {
        barButtonItemHeightWidth / 2
    }
    
    // MARK: - Subviews
    
    private(set) lazy var closeBarButtonItem: UIBarButtonItem = {
        let button = UIButton(sfSymbol: .xMark)
        button.backgroundColor = .white
        button.tintColor = ._black
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: barButtonItemHeightWidth).isActive = true
        button.widthAnchor.constraint(equalToConstant: barButtonItemHeightWidth).isActive = true
        button.layer.cornerRadius = barButtonItemCornerRadius
        button.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    private(set) lazy var likeBarButtonItem: UIBarButtonItem = {
        let button = UIButton(sfSymbol: .heart)
        button.backgroundColor = .white
        button.tintColor = ._black
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: barButtonItemHeightWidth).isActive = true
        button.widthAnchor.constraint(equalToConstant: barButtonItemHeightWidth).isActive = true
        button.layer.cornerRadius = barButtonItemCornerRadius
        button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    private(set) lazy var shareBarButtonItem: UIBarButtonItem = {
        let button = UIButton(sfSymbol: .squareAndArrowUp)
        button.backgroundColor = .white
        button.tintColor = ._black
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: barButtonItemHeightWidth).isActive = true
        button.widthAnchor.constraint(equalToConstant: barButtonItemHeightWidth).isActive = true
        button.layer.cornerRadius = barButtonItemCornerRadius
        button.addTarget(self, action: #selector(handleShare), for: .touchUpInside)
        return UIBarButtonItem(customView: button)
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceHorizontal = false
        view.alwaysBounceVertical = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var eventImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var eventActionView: EventActionView = {
        let view = EventActionView()
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleClose() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleLike() {
        print("like")
    }
    
    @objc private func handleShare() {
        print("share")
    }
    
    // MARK: - Initialize Subviews
    
    fileprivate func initializeSubviews() {
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItems = [closeBarButtonItem]
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        stackView.addArrangedSubview(eventImageView)
        stackView.addArrangedSubview(eventActionView)
        
        eventImageView.heightAnchor.constraint(equalToConstant: eventImageViewHeight).isActive = true
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = ._black
    }
}
