//
//  StackView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 8/1/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

class StackView: UIScrollView {
    
    // MARK: - Private Properties
    
    // MARK: - Public Properties
    var _axis: NSLayoutConstraint.Axis = .vertical {
        didSet {
            stackView.axis = _axis
            switch _axis {
            case .vertical:
                alwaysBounceVertical = true
                alwaysBounceHorizontal = false
                showsHorizontalScrollIndicator = false
                showsVerticalScrollIndicator = true
            default:
                alwaysBounceVertical = false
                alwaysBounceHorizontal = true
                showsHorizontalScrollIndicator = true
                showsVerticalScrollIndicator = false
            }
        }
    }
    
    // MARK: - Subviews
    private(set) lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .clear
        view.axis = .vertical
        view.spacing = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Private Utils
    private func setAxis(_ axis: NSLayoutConstraint.Axis) {
        self._axis = axis
    }
    
    // MARK: - Public Utils
    func addToStack(
        _ message: String,
        topPadding: CGFloat = TextView()._padding.top,
        rightPadding: CGFloat = TextView()._padding.right,
        bottomPadding: CGFloat = TextView()._padding.bottom,
        leftPadding: CGFloat = TextView()._padding.left
    ) {
        let textView: TextView = TextView(
            text: message,
            textColor: ._gray,
            font: UIFont(type: .regular, size: .small)
        )
        textView._padding = UIEdgeInsets(
            top: topPadding,
            left: leftPadding,
            bottom: bottomPadding,
            right: rightPadding
        )
        addArrangedSubview(
            textView
        )
    }
    
    public func addVerticalEmptySpace(_ height: CGFloat) {
        stackView.addVerticalEmptySpace(height)
    }
    
    public func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
    
    public func addArrangedSubviews(_ views: [UIView]) {
        stackView.addArrangedSubviews(views)
    }
    
    // MARK: - Initialize Subviews
    private func initializeSubviews() {
        backgroundColor = ._background
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: - Init
    init(_ axis: NSLayoutConstraint.Axis) {
        super.init(frame: .zero)
        initializeSubviews()
        setAxis(axis)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        initializeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
