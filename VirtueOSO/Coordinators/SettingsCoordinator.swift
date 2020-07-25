//
//  SettingsCoordinator.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/25/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation
import UIKit

//MARK:- SettingsCoordinator
class SettingsCoordinator: Coordinator {
    
    //MARK:- Enums
    enum Destination: Int {
        case root
        /// Personal Settings
        case personalInfo
        case profile
        case mySubscription
        case linkedAccounts
        
        /// Home
        case preferences
        
        /// Device
        case notifications
        case changePassword
        case changeLoginPIN
        case enableFaceID
        
        /// Support
        case supportTeam
        case rate
        case sendFeedback
        case legal
        
        /// Legal Links
        case termsAndConditions
        case privacyPolicy
        case programAgreement
        case referralAgreement
        case importantDisclosures
        case spendTermsAndConditions
        case spendElectronicFundsTransfersDisclosure
        case spendFundsAvailability
        case spendPrivacyPolicy
    }
    
    //MARK:- Public Properties
    internal var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK:- Start
    func start() {
        navigate(to: .root)
    }
    
    //MARK:- Coordinator
    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    //MARK:- Private
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .root:
            return self.createSettingsRootViewController()
        case .preferences:
            return self.createHomePreferencesViewController()
        case .legal:
            return self.createLegalSettingsViewController()
        default:
            return UIViewController()
        }
    }
    
    //MARK:- CreateSettingsRootViewController
    private lazy var logoutButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoutButton: Button = {
        let view = Button()
        view._font = UIFont(type: .medium, size: .small)
        view._title = "Log Out"
        view._borderWidth = 0.5
        view._cornerRadius = 22
        view.backgroundColor = .clear
        view._borderColor = ._gray
        view._textColor = .black
        return view
    }()
    private lazy var appVersionLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 1
        view.text = "Version 3.11.5.218062"
        view.textAlignment = .center
        view.backgroundColor = .clear
        view.textColor = ._gray
        view.font = UIFont(type: .regular, size: .small)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private func createSettingsRootViewController() -> SettingsViewController {
        //MARK:- Init Log Out
        logoutButtonView.addSubview(logoutButton)
        logoutButton.topAnchor.constraint(equalTo: logoutButtonView.topAnchor).isActive = true
        logoutButton.leftAnchor.constraint(equalTo: logoutButtonView.leftAnchor, constant: 20).isActive = true
        logoutButton.rightAnchor.constraint(equalTo: logoutButtonView.rightAnchor, constant: -20).isActive = true
        logoutButtonView.bottomAnchor.constraint(equalTo: logoutButton.bottomAnchor).isActive = true
        
        let subviews: [UIView] = [
            /// Personal Settings
            SettingsHeaderCellView(header: "Personal Settings"),
            SettingsCellView(
                title: "Personal Info",
                image: UIImage(),
                tag: Destination.personalInfo.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Profile",
                image: UIImage(),
                tag: Destination.profile.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "My Subscription",
                image: UIImage(),
                detail: "Personal",
                detailTextColor: ._tertiary,
                tag: Destination.mySubscription.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Linked Accounts",
                image: UIImage(),
                tag: Destination.linkedAccounts.rawValue,
                delegate: self
            ),
            
            /// Home
            SettingsHeaderCellView(header: "Home"),
            SettingsCellView(
                title: "Preferences",
                image: UIImage(),
                tag: Destination.preferences.rawValue,
                delegate: self
            ),
            
            /// Device
            SettingsHeaderCellView(header: "Device"),
            SettingsCellView(
                title: "Notifications",
                image: UIImage(),
                tag: Destination.notifications.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Change Password",
                image: UIImage(),
                tag: Destination.changePassword.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Change Log In PIN",
                image: UIImage(),
                tag: Destination.changeLoginPIN.rawValue,
                delegate: self
            ),
            SettingsCellToggleView(
                title: "Enable Face ID",
                isOn: false,
                image: UIImage(),
                tag: Destination.enableFaceID.rawValue,
                delegate: self
            ),
            
            /// Support
            SettingsHeaderCellView(header: "Support"),
            SettingsCellView(
                title: "Support Team",
                tag: Destination.supportTeam.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Rate VirtueOSO",
                tag: Destination.rate.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Send Feedback",
                tag: Destination.sendFeedback.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Legal",
                tag: Destination.legal.rawValue,
                delegate: self
            ),
            
            /// Logout Button
            EmptySpaceView(30),
            logoutButtonView,
            
            /// App Version
            EmptySpaceView(20),
            appVersionLabel
        ]
        
        let settingsController = SettingsViewController(coordinator: self, subviews: subviews)
        settingsController._title = "My Settings"
        return settingsController
    }
    
    //MARK:- Home Preferences
    private func createHomePreferencesViewController() -> SettingsViewController {
        let subviews: [UIView] = [
            EmptySpaceView(20),
            SettingsCellToggleView(
                title: "Earn Found Money carousel",
                isOn: true,
                tag: 1,
                delegate: self
            )
        ]
        let settingsController = SettingsViewController(coordinator: self, subviews: subviews)
        settingsController._title = "Home Preferences"
        return settingsController
    }
    
    //MARK:- Legal
    /**
     case termsAndConditions
     case privacyPolicy
     case programAgreement
     case referralAgreement
     case importantDisclosures
     case spendTermsAndConditions
     case spendElectronicFundsTransfersDisclosure
     case spendFundsAvailability
     case spendPrivacyPolicy
     */
    private func createLegalSettingsViewController() -> SettingsViewController {
        let subviews: [UIView] = [
            SettingsCellView(
                title: "Terms and Conditions",
                tag: Destination.termsAndConditions.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Privacy Policy",
                tag: Destination.privacyPolicy.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Program Agreement",
                tag: Destination.programAgreement.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Referral Agreement",
                tag: Destination.referralAgreement.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Important Disclosures",
                tag: Destination.importantDisclosures.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Spend Terms and Conditions",
                tag: Destination.spendTermsAndConditions.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Spend Electronic Funds Transfers Disclosure",
                tag: Destination.spendElectronicFundsTransfersDisclosure.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Spend Funds Availability",
                tag: Destination.spendFundsAvailability.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Spend Privacy Policy",
                tag: Destination.spendPrivacyPolicy.rawValue,
                delegate: self
            )
        ]
        let settingsController = SettingsViewController(coordinator: self, subviews: subviews)
        settingsController._title = "Legal"
        return settingsController
    }
}

//MARK:- SettingsCellViewDelegate
extension SettingsCoordinator: SettingsCellViewDelegate {
    func settingsCellView(_ settingsCellView: SettingsCellView, didTap tag: Int) {
        switch tag {
        case Destination.root.rawValue:
            navigate(to: .root)
        case Destination.preferences.rawValue:
            navigate(to: .preferences)
        case Destination.legal.rawValue:
            navigate(to: .legal)
        default:
            break
        }
    }
}

//MARK:- SettingsCellToggleViewDelegate
extension SettingsCoordinator: SettingsCellToggleViewDelegate {
    func settingsCellToggleView(_ settingsCellToggleView: SettingsCellToggleView, didToggle isOn: Bool, tag: Int) {
        print("\(tag) isOn: \(isOn)")
    }
}
