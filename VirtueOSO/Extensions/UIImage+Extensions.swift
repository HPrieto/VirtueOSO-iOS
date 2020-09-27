//
//  UIImage+Extensions.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 7/25/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

extension UIImage {
    
    // MARK: - SF Symbols
    public enum SFSymbol: String {
        
        // MARK: A
        case arrowLeft = "arrow.left"
        case arrowTop = "arrow.top"
        case arrowRight = "arrow.right"
        case arrowBottom = "arrow.bottom"
        case arrowShapeTurnUpLeft = "arrowshape.turn.up.left"
        case arrowShapeTurnUpLeftFill = "arrowshape.turn.up.left.fill"
        case arrowShapeTurnUpRight = "arrowshape.turn.up.right"
        case arrowShapeTurnUpRightFill = "arrowshape.turn.up.right.fill"
        case arrowClockwise = "arrow.clockwise"
        case arrowCounterClockwise = "arrow.counterclockwise"
        
        // MARK: - B
        case bell = "bell"
        case bellFill = "bell.fill"
        case bolt = "bolt"
        case boltFill = "bolt.fill"
        case boltSlash = "bolt.slash"
        case boltSlashFill = "bolt.slash.fill"
        case bookmark = "bookmark"
        case bookmarkFill = "bookmark.fill"
        case bubbleMiddleBottom = "bubble.middle.bottom"
        case bubbleMiddleBottomFill = "bubble.middle.bottom.fill"
        
        // MARK: - C
        case camera = "camera"
        case cameraFill = "camera.fill"
        case cameraRotate = "camera.rotate"
        case cameraRotateFill = "camera.rotate.fill"
        case checkmark = "checkmark"
        case chevronLeft = "chevron.left"
        case chevronTop = "chevron.top"
        case chevronRight = "chevron.right"
        case chevronBottom = "chevron.bottom"
        case clock = "clock"
        case clockFill = "clock.fill"
        case creditCard = "creditcard"
        case creditCardFill = "creditcard.fill"
        
        // MARK: - E
        case eject = "eject"
        case ejectFill = "eject.fill"
        case ellipses = "ellipses"
        case ellipsesCircle = "ellipses.circle"
        case ellipsesCircleFill = "ellipses.circle.fill"
        case ellipsesBubble = "ellipses.bubble"
        case ellipsesBubbleFill = "ellipses.bubble.fill"
        case eye = "eye"
        case eyeFill = "eye.fill"
        case eyeSlash = "eye.slash"
        case eyeSlashFill = "eye.slash.fill"
        
        // MARK: F
        case flashlightOffFill = "flashlight.off.fill"
        case flashlightOnFill = "flashlight.on.fill"
        
        // MARK: H
        case heart = "heart"
        case heartFill = "heart.fill"
        case house = "house"
        case houseFill = "house.fill"
        
        // MARK: I
        case info = "info"
        case infoCircle = "info.circle"
        case infoCircleFill = "info.circle.fill"
        
        // MARK: L
        case link = "link"
        case lineHorizontal3 = "line.horizontal.3"
        case lock = "lock"
        case lockFill = "lock.fill"
        case lockOpen = "lock.open"
        case lockOpenFill = "lock.open.fill"
        
        // MARK: M
        case magnifyingGlass = "magnifyingglass"
        case mic = "mic"
        case micFill = "mic.fill"
        case micSlash = "mic.slash"
        case micSlashFill = "mic.slash.fill"
        case moon = "moon"
        
        // MARK: P
        case plusRectangle = "plus.rectangle"
        case plusRectangleFill = "plus.rectangle.fill"
        case paperPlane = "paperplane"
        case paperPlaneFill = "paperplane.fill"
        case pencil = "pencil"
        case person = "person"
        case personFill = "person.fill"
        case personBadgePlus = "person.badge.plus"
        case personBadgePlusFill = "person.badge.plus.fill"
        case play = "play"
        case playFill = "play.fill"
        case plus = "plus"
        
        // MARK: Q
        case qrCode = "qrcode"
        case qrCodeViewFinder = "qrcode.viewfinder"
        case questionMark = "questionmark"
        case questionMarkCircle = "questionmark.circle"
        case questionMarkCircleFill = "questionmark.circle.fill"
        
        // MARK: R
        case rectangleGrid3x2 = "rectangle.grid.3x2"
        case rectangleGrid3x2Fill = "rectangle.grid.3x2.fill"
        
        // MARK: S
        case shield = "shield"
        case shieldFill = "shield.fill"
        case sliderHorizontal3 = "slider.horizontal.3"
        case speaker = "speaker"
        case speakerFill = "speaker.fill"
        case speakerSlash = "speaker.slash"
        case speakerSlashFill = "speaker.slash.fill"
        case squareAndPencil = "square.and.pencil"
        case squareOnSquare = "square.on.square"
        case squareOnSquareFill = "square.on.square.fill"
        
        // MARK: T
        case trash = "trash"
        case trashFill = "trash.fill"
        
        // MARK: V
        case video = "video"
        case videoFill = "video.fill"
        
        // MARK: X
        case xCircle = "x.cicle"
        case xCircleFill = "x.circle.fill"
    }
    
    convenience init?(sfSymbol: SFSymbol, withWeight weight: SymbolWeight = .regular) {
        let configuration = UIImage.SymbolConfiguration(weight: weight)
        self.init(systemName: sfSymbol.rawValue, withConfiguration: configuration)
    }
    
    static let _backArrow: UIImage? = UIImage(named: "back-arrow")?.withRenderingMode(.alwaysTemplate)
    
    static let _unlocked: UIImage? = UIImage(named: "unlocked")?.withRenderingMode(.alwaysTemplate)
    static let _locked: UIImage? = UIImage(named: "locked")?.withRenderingMode(.alwaysTemplate)
    
    static let _upArrow25: UIImage? = UIImage(named: "up-arrow25")?.withRenderingMode(.alwaysTemplate)
}
