//
//  LoadingBarView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 8/8/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - LoadingBarView
class LoadingBarView: UIView {
    
    // MARK: - Private Properties
    private var heightLayoutConstraint: NSLayoutConstraint?
    private var progressWidthLayoutConstraint: NSLayoutConstraint?
    
    // MARK: - Public Properties
    var _progressBarColor: UIColor = ._primary {
        willSet {
            progressBar.backgroundColor = _progressBarColor
        }
    }
    
    private var _progress: CGFloat = 0 {
        didSet {
            let viewWidth: CGFloat = frame.width
            let widthPercent: CGFloat = min(
                100.0, // Maximum percentage
                max(
                    0, // Minimum percentage
                    _progress
                )
            )
            let progressWidth: CGFloat = abs(viewWidth * (widthPercent / 100))
            print(progressWidth, _progress)
            progressWidthLayoutConstraint?.constant = progressWidth
        }
    }
    
    var _height: CGFloat = 2 {
        willSet {
            heightLayoutConstraint?.constant = newValue
        }
    }
    
    // MARK: - Subviews
    private lazy var progressBar: UIView = {
        let view = UIView()
        view.backgroundColor = _progressBarColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Utils
    public func setProgress(percent progress: CGFloat, withDuration duration: TimeInterval = 1.25, _ completionHandler: ((Bool) -> Void)? = nil) {
        self._progress = progress
        UIView.animate(withDuration: duration, animations: {
            self.layoutIfNeeded()
        }, completion: completionHandler)
    }
    
    // MARK: - Initialize Subviews
    private func initializeSubviews() {
        backgroundColor = ._lightGray
        translatesAutoresizingMaskIntoConstraints = false
        
        heightLayoutConstraint = heightAnchor.constraint(equalToConstant: _height)
        heightLayoutConstraint?.isActive = true
        
        addSubview(progressBar)
        
        progressBar.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        progressBar.topAnchor.constraint(equalTo: topAnchor).isActive = true
        progressBar.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        progressWidthLayoutConstraint = progressBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: _progress)
        progressWidthLayoutConstraint?.isActive = true
        
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initializeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
