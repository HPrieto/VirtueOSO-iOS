//
//  ProfileTableView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/27/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - ProfileTableViewDelegate

protocol ProfileTableViewDelegate {
    
    func profileTableView(_ profileTableView: ProfileTableView, didSelectRowAt indexPath: IndexPath)
    
    func profileTableView(_ profileTableView: ProfileTableView, cell: ProfileTableViewCell, cellForRowAt indexPath: IndexPath)
    
}

// MARK: - ProfileTableView

class ProfileTableView: UITableView {
    
    // MARK: - Constants
    
    // MARK: - Public Properties
    var viewModel: ProfileViewModel
    
    public var profileDelegate: ProfileTableViewDelegate?
    
    // MARK: - Initialize
    private func initialize() {
        delegate = self
        dataSource = self
        backgroundColor = .white
        separatorStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
        register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect, style: UITableView.Style) {
        self.viewModel = ProfileViewModel()
        super.init(frame: frame, style: .grouped)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewDelegate

extension ProfileTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier) as! ProfileTableViewCell
        let model: Profile = viewModel.models[indexPath.row]
        cell.titleLabel.text = "\(model.firstname) \(model.lastname)"
        cell.descriptionLabel.text = "Artist"
        cell.profileImageView.setImage(fromUrlString: model.imageUrl)
        cell.roundProfileImageViewCorners()
        profileDelegate?.profileTableView(self, cell: cell, cellForRowAt: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileDelegate?.profileTableView(self, didSelectRowAt: indexPath)
    }
}

// MARK: - Test Data

extension ProfileTableView {
    
    public func generateTestData(_ count: Int = 10) {
        var testModels: [Profile] = [Profile]()
        for i in 0 ..< count {
            let event: Profile = Profile(
                id: UUID(),
                username: "Yeezy(\(i))",
                firstname: "Kanye",
                lastname: "West",
                imageUrl: "data:image/jpeg;base64,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",
                createdDate: Date(),
                updatedDate: Date()
            )
            testModels.append(event)
        }
        self.viewModel.models = testModels
    }
}
