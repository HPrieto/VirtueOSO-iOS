//
//  EventTableViewCell.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/24/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - EventTableViewCell
class EventDetailTableViewCell: UITableViewCell, TableViewCellDataSource {
    
    // MARK: - Public Properteis
    
    public var model: Event? {
        didSet {
            guard let event: Event = model else { return }
            
            titleLabel.text = event.title
            descriptionLabel.text = event.description
            nameLabel.text = event.name
            timestampLabel.text = event.timestamp.toString()
            eventImageView.setImage(fromUrlString: event.imageUrl)
        }
    }
    
    // MARK: - Static Properties
    
    public static let reuseIdentifier: String = "event-detail-table-view-cell"
    public static let cellHeight: CGFloat = 150
    
    // MARK: - Private Properties
    
    private let viewCornerRadius: CGFloat = 8
    private let viewTopAnchorConstant: CGFloat = 15
    private var viewBottomAnchorConstant: CGFloat {
        return -viewTopAnchorConstant
    }
    private let viewLeftAnchorConstant: CGFloat = 20
    private var viewRightAnchorConstant: CGFloat {
        return -viewLeftAnchorConstant
    }
    
    private let topAnchorConstant: CGFloat = 10
    private var bottomAnchorConstant: CGFloat {
        return -topAnchorConstant
    }
    private let leftAnchorConstant: CGFloat = 10
    private var rightAnchorConstant: CGFloat {
        return -leftAnchorConstant
    }
    
    private let eventImageCornerRadius: CGFloat = 4
    private let eventImageViewHeightConstant: CGFloat = 60
    private var eventImageViewWidthConstant: CGFloat {
        return eventImageViewHeightConstant
    }
    
    private let playButtonHeightConstant: CGFloat = 25
    private var playButtonWidthConstant: CGFloat {
        return playButtonHeightConstant
    }
    private var playButtonCornerRadius: CGFloat {
        return playButtonHeightConstant / 2
    }
    private let playImageViewHeightConstant: CGFloat = 15
    private var playImageViewWidthConstant: CGFloat {
        return playImageViewHeightConstant
    }
    
    private let titleButtonHeight: CGFloat = 20
    private var titleButtonWidth: CGFloat {
        return titleButtonHeight
    }
    
    // MARK: - Closures
    
    public var handleTitleButtonTapped: ((_ button: UIButton) -> ())?
    
    // MARK: - Subviews
    
    private(set) lazy var view: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = viewCornerRadius
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addShadow()
        return view
    }()
    
    private(set) lazy var eventImageView: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = eventImageCornerRadius
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
        view.adjustsFontSizeToFitWidth = true
        //view.sizeToFit()
        view.font = UIFont(type: .demiBold, size: .small)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var titleButton: UIButton = {
        let view = UIButton(sfSymbol: .ellipses, withWeight: .semibold)
        view.tintColor = ._gray
        view.addTarget(self, action: #selector(handleCallTitleButtonTap), for: .touchUpInside)
        return view
    }()
    
    private(set) lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.adjustsFontSizeToFitWidth = true
        view.font = UIFont(type: .medium, size: 12)
        view.textColor = ._gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 3
        view.font = UIFont(type: .medium, size: 14)
        view.textColor = ._darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var timestampLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.textColor = ._gray
        view.font = UIFont(type: .medium, size: 10)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private(set) lazy var playButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = ._black
        view.tintColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = playButtonCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let imageView = UIImageView()
        imageView.image = UIImage(sfSymbol: .playFill)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.heightAnchor.constraint(equalToConstant: playImageViewHeightConstant).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: playImageViewWidthConstant).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    
    // MARK: - Handlers
    
    @objc private func handleCallTitleButtonTap(sender: UIButton) {
        handleTitleButtonTapped?(sender)
    }
    
    // MARK: - Initialize Subviews
    
    public func initializeSubviews() {
        selectionStyle = .none
        
        addSubview(view)
        
        view.topAnchor.constraint(equalTo: topAnchor, constant: viewTopAnchorConstant).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor, constant: viewLeftAnchorConstant).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor, constant: viewRightAnchorConstant).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: viewBottomAnchorConstant).isActive = true
        
        view.addSubview(eventImageView)
        view.addSubview(titleLabel)
        view.addSubview(titleButton)
        view.addSubview(nameLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(timestampLabel)
        view.addSubview(playButton)
        
        eventImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftAnchorConstant).isActive = true
        eventImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: topAnchorConstant).isActive = true
        eventImageView.heightAnchor.constraint(equalToConstant: eventImageViewHeightConstant).isActive = true
        eventImageView.widthAnchor.constraint(equalToConstant: eventImageViewWidthConstant).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: eventImageView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: titleButton.leftAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: eventImageView.heightAnchor, multiplier: 0.7).isActive = true
        
        titleButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: rightAnchorConstant - 5).isActive = true
        titleButton.heightAnchor.constraint(equalToConstant: titleButtonHeight).isActive = true
        titleButton.widthAnchor.constraint(equalToConstant: titleButtonWidth).isActive = true
        titleButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        
        nameLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: eventImageView.bottomAnchor).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 15).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: eventImageView.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleButton.rightAnchor).isActive = true
        
        playButton.leftAnchor.constraint(equalTo: eventImageView.leftAnchor).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: playButtonWidthConstant).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: playButtonHeightConstant).isActive = true
        playButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15).isActive = true
        
        timestampLabel.leftAnchor.constraint(equalTo: playButton.rightAnchor, constant: 10).isActive = true
        timestampLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        timestampLabel.centerYAnchor.constraint(equalTo: playButton.centerYAnchor).isActive = true
        
        bottomAnchor.constraint(equalTo: playButton.bottomAnchor, constant: -(viewBottomAnchorConstant - 10)).isActive = true
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
