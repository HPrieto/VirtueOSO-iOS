//
//  TitleView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/11/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class TitleView: ComponentView {
    
    var _color: UIColor = ._black {
        didSet {
            titleTextView.textColor = _color
            subtitleTextView.textColor = _color
        }
    }
    
    var _title: String = "" {
        didSet {
            titleTextView.text = _title
        }
    }
    
    var _subtitle: String = "" {
        didSet {
            subtitleTextView.text = _subtitle
        }
    }
    
    lazy var titleTextView: TextView = {
        let view = TextView()
        view.font = UIFont(type: .bold, size: .title2)
        return view
    }()
    
    lazy var subtitleTextView: TextView = {
        let view = TextView()
        view.font = UIFont(type: .regular, size: .regular)
        return view
    }()
    
    init(title: String, subtitle: String = "") {
        super.init(frame: CGRect.zero)
        self._title = title
        self._subtitle = subtitle
        self.titleTextView.text = title
        self.subtitleTextView.text = subtitle
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        initializeSubviews()
    }
    
    override func initializeSubviews() {
        addSubview(titleTextView)
        addSubview(subtitleTextView)
        
        titleTextView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleTextView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        titleTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        subtitleTextView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        subtitleTextView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        subtitleTextView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor).isActive = true
        subtitleTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        
    }
    
    override func updateSubviews() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
