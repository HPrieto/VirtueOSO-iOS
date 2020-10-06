//
//  SettingsCoordinator.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/25/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import Foundation
import UIKit

// MARK: - SettingsCoordinator
class ProfileCoordinator: Coordinator {
    
    // MARK: - Private Properties
    private(set) var mainCoordinator: MainCoordinator
    
    // MARK: - Public Properties
    private(set) lazy var rootViewController: UINavigationController = {
        let controller = UINavigationController()
        controller.navigationBar.tintColor = ._black
        controller.navigationBar.backgroundColor = .white
        controller.navigationBar.isTranslucent = true
        controller.navigationBar.barTintColor = .white
        controller.navigationBar.titleTextAttributes = [.foregroundColor: UIColor._black, .font: UIFont(type: .demiBold, size: .regular) as Any]
        controller.navigationBar.barStyle = .default
        return controller
    }()
    
    // MARK: - Enums
    enum Destination: Int {
        case root
        case settings
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
    
    // MARK: PersonalSettingsViewController
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
        view.addTarget(
            self,
            action: #selector(handleLogout),
            for: .touchUpInside)
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
    
    // MARK: - Controllers
    
    private lazy var profileViewController: ProfileViewController = {
        let controller = ProfileViewController(coordinator: self)
        return controller
    }()
    
    private lazy var settingsRootViewController: SettingsViewController = {
        // MARK: - Init Log Out
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
                systemImageName: "person",
                tag: Destination.personalInfo.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Profile",
                systemImageName: "headphones",
                tag: Destination.profile.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "My Subscription",
                systemImageName: "bag.badge.plus",
                detail: "Personal",
                detailTextColor: ._tertiary,
                tag: Destination.mySubscription.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Linked Accounts",
                systemImageName: "person.2.square.stack",
                tag: Destination.linkedAccounts.rawValue,
                delegate: self
            ),
            
            /// Home
            SettingsHeaderCellView(header: "Home"),
            SettingsCellView(
                title: "Preferences",
                systemImageName: "slider.horizontal.3",
                tag: Destination.preferences.rawValue,
                delegate: self
            ),
            
            /// Device
            SettingsHeaderCellView(header: "Device"),
            SettingsCellView(
                title: "Notifications",
                systemImageName: "app.badge",
                tag: Destination.notifications.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Change Password",
                systemImageName: "lock",
                tag: Destination.changePassword.rawValue,
                delegate: self
            ),
            SettingsCellView(
                title: "Change Log In PIN",
                systemImageName: "circle.grid.3x3.fill",
                tag: Destination.changeLoginPIN.rawValue,
                delegate: self
            ),
            SettingsCellToggleView(
                title: "Enable Face ID",
                systemImageName: "faceid",
                isOn: false,
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
            appVersionLabel,
            EmptySpaceView(20)
        ]
        
        let controller = SettingsViewController(coordinator: self, subviews: subviews)
        controller._title = "My Settings"
        return controller
    }()
    
    // MARK: - PersonalInfoViewController
    private(set) lazy var personalInfoViewController: PersonalInfoViewController = {
        let controller = PersonalInfoViewController()
        controller._title = "Personal Info"
        return controller
    }()
    
    // MARK: - TermsAndConditionsViewController
    private(set) lazy var termsAndConditionsViewController: WebViewController = {
        let controller = WebViewController("https://www.airbnb.com/terms")
        controller.navigationItem.title = "Terms & Conditions"
        return controller
    }()
    
    // MARK: - PrivacyPolicyViewController
    private(set) lazy var privacyPolicyViewController: WebViewController = {
        let controller = WebViewController("https://www.airbnb.com/terms/privacy_policy")
        controller.navigationItem.title = "Virtuoso Privacy Policy"
        return controller
    }()
    
    // MARK: - HomePreferencesViewController
    private(set) lazy var homePreferencesViewController: SettingsViewController = {
        let subviews: [UIView] = [
            EmptySpaceView(20),
            SettingsCellToggleView(
                title: "Earn Found Money carousel",
                isOn: true,
                tag: 1,
                delegate: self
            )
        ]
        let controller = SettingsViewController(coordinator: self, subviews: subviews)
        controller._title = "Home Preferences"
        return controller
    }()
    
    // MARK: - ChangePasswordViewController
    private lazy var changePasswordViewController: ChangePasswordViewController = {
        return ChangePasswordViewController()
    }()
    
    //MARK: - LegalSettingsViewController
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
    private lazy var legalSettingsViewController: SettingsViewController = {
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
        let controller = SettingsViewController(coordinator: self, subviews: subviews)
        controller._title = "Legal"
        return controller
    }()
    
    // MARK: - Init
    
    init(mainCoordinator: MainCoordinator) {
        self.mainCoordinator = mainCoordinator
    }
    
    // MARK: - Start
    func start() {
        navigate(to: .root)
    }
    
    // MARK: - Coordinator
    func navigate(to destination: Destination) {
        let viewController = makeViewController(for: destination)
        rootViewController.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Private
    private func makeViewController(for destination: Destination) -> UIViewController {
        switch destination {
        case .root:
            return profileViewController
        case .settings:
            return settingsRootViewController
        case .personalInfo:
            return personalInfoViewController
        case .preferences:
            return homePreferencesViewController
        case .changePassword:
            return changePasswordViewController
        case .legal:
            return legalSettingsViewController
        case .termsAndConditions:
            return termsAndConditionsViewController
        case .privacyPolicy:
            return privacyPolicyViewController
        default:
            return UIViewController()
        }
    }
    
    // MARK: - Handlers
    @objc private func handleGoBack() {
        rootViewController.popViewController(animated: true)
    }
}

//MARK: - SettingsCellViewDelegate
extension ProfileCoordinator: SettingsCellViewDelegate {
    func settingsCellView(_ settingsCellView: SettingsCellView, didTap tag: Int) {
        switch tag {
        case Destination.settings.rawValue:
            navigate(to: .settings)
        case Destination.personalInfo.rawValue:
            navigate(to: .personalInfo)
        case Destination.preferences.rawValue:
            navigate(to: .preferences)
        case Destination.changePassword.rawValue:
            navigate(to: .changePassword)
        case Destination.legal.rawValue:
            navigate(to: .legal)
        case Destination.termsAndConditions.rawValue:
            navigate(to: .termsAndConditions)
        case Destination.privacyPolicy.rawValue:
            navigate(to: .privacyPolicy)
        default:
            break
        }
    }
}

//MARK: - SettingsCellToggleViewDelegate
extension ProfileCoordinator: SettingsCellToggleViewDelegate {
    func settingsCellToggleView(_ settingsCellToggleView: SettingsCellToggleView, didToggle isOn: Bool, tag: Int) {
        print("\(tag) isOn: \(isOn)")
    }
}
