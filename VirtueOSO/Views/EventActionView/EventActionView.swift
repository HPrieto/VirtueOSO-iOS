//
//  EventActionView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 1/11/21.
//  Copyright © 2021 Heriberto Prieto. All rights reserved.
//

import UIKit

class EventActionView: UIView {
    
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
                var attributedTitle: [NSAttributedString] = [NSAttributedString]()
                
                if let playButtonImage: UIImage = UIImage(sfSymbol: .playFill),
                   let playButtonAttrString: NSAttributedString = NSAttributedString(image: playButtonImage) {
                    attributedTitle.append(playButtonAttrString)
                }
                
                attributedTitle.append(NSAttributedString(string: " PLAY"))
                
                let attributedTitleString: String = NSMutableAttributedString(attributedStrings: attributedTitle).string
                playButton.setTitle(attributedTitleString, for: .normal)
            case .resume:
                var attributedTitle: [NSAttributedString] = [NSAttributedString]()
                
                if let playButtonImage: UIImage = UIImage(sfSymbol: .playFill),
                   let playButtonAttrString: NSAttributedString = NSAttributedString(image: playButtonImage) {
                    attributedTitle.append(playButtonAttrString)
                }
                
                attributedTitle.append(NSAttributedString(string: " RESUME"))
                
                let attributedTitleString: String = NSMutableAttributedString(attributedStrings: attributedTitle).string
                playButton.setTitle(attributedTitleString, for: .normal)
            case .error:
                backgroundColor = .red
            }
        }
    }
    
    // MARK: - Subviews
    
    private(set) lazy var playButton: UIButton = {
        let view = UIButton()
        view.setTitle("Follow", for: .normal)
        view.tintColor = .white
        view.backgroundColor = ._blue
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor._blue.cgColor
        view.layer.cornerRadius = 4
        view.titleLabel?.font = UIFont(type: .demiBold, size: 14)
        view.setTitleColor(.white, for: .normal)
        view.contentEdgeInsets = UIEdgeInsets(top: 7, left: 15, bottom: 7, right: 15)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Initialize Subviews
    
    fileprivate func initializeSubviews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(playButton)
        
        playButton.leftAnchor.constraint(equalTo: leftAnchor, constant: Theme.Margins.left).isActive = true
        playButton.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        
        bottomAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10).isActive = true
        rightAnchor.constraint(greaterThanOrEqualTo: playButton.rightAnchor, constant: Theme.Margins.right).isActive = true
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
