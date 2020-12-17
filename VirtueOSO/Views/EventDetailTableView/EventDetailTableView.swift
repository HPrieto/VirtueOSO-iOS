//
//  EventDetailTableView.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 10/27/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - EventDetailTableViewDelegate
protocol EventDetailTableViewDelegate {
    func eventDetailTableView(_ eventDetailTableView: EventDetailTableView, didSelectRowAt indexPath: IndexPath)
}

// MARK: - EventDetailTableView
class EventDetailTableView: UITableView {
    
    // MARK: - Private Properties
    
    private var heightLayoutConstraint: NSLayoutConstraint?
    
    // MARK: - Public Properties
    
    var viewModel: EventViewModel
    
    var eventDelegate: EventDetailTableViewDelegate?
    
    var height: CGFloat {
        var result: CGFloat = 0
        let numberOfSections: Int = self.numberOfSections
        for section in 0 ..< numberOfSections {
            let numberOfRows: Int = self.numberOfRows(inSection: section)
            result += 44
            result += CGFloat(numberOfRows * 44)
        }
        return result
    }
    
    // MARK: - Initialize
    
    private func initialize() {
        backgroundColor = .white
        separatorStyle = .none
        translatesAutoresizingMaskIntoConstraints = false
        
        delegate = self
        dataSource = self
        register(EventDetailTableViewCell.self, forCellReuseIdentifier: EventDetailTableViewCell.reuseIdentifier)
        register(TitleTableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: TitleTableViewHeaderFooterView.reuseIdentifier)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect, style: UITableView.Style) {
        self.viewModel = EventViewModel()
        super.init(frame: frame, style: .grouped)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Utils
extension EventDetailTableView {
    
    public func setFixedHeight() {
        if heightLayoutConstraint == nil {
            heightLayoutConstraint = heightAnchor.constraint(equalToConstant: 0)
            heightLayoutConstraint?.isActive = true
        }
        heightLayoutConstraint?.constant = height
    }
}

// MARK: - UITableViewDelegate
extension EventDetailTableView: UITableViewDelegate, UITableViewDataSource {
    
    override func numberOfRows(inSection section: Int) -> Int {
        return viewModel.models.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: TitleTableViewHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TitleTableViewHeaderFooterView.reuseIdentifier) as! TitleTableViewHeaderFooterView
        switch section {
        case 0:
            header.titleLabel.text = "Now Live"
        default:
            header.titleLabel.text = "Past Events"
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: EventDetailTableViewCell.reuseIdentifier) as! EventDetailTableViewCell
        cell.model = viewModel.models[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventDelegate?.eventDetailTableView(self, didSelectRowAt: indexPath)
    }
}

// MARK: - Generate Test Data
extension EventDetailTableView {
    
    public func generateTestData(_ count: Int = 10) {
        var testModels: [Event] = [Event]()
        for i in 0 ..< count {
            let event: Event = Event(
                id: UUID(),
                title: "TEST_TITLE #\(i) - FA/HOCKEY, Kareem Campbell",
                name: "Test Name",
                description: "We discuss the FA/Hockey 'Dancing On Thin Ice Vide', Anderson Cooper talks with Tony Hawk | We discuss the FA/Hockey 'Dancing On Thin Ice Vide', Anderson Cooper talks with Tony Hawk",
                imageUrl: "https://i.insider.com/576bf03552bcd020008cb17b?width=1136&format=jpeg",
                timestamp: Date()
            )
            testModels.append(event)
        }
        self.viewModel.models = testModels
    }
}
