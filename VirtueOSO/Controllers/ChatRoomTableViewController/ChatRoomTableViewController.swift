//
//  ChatRoomViewController.swift
//  VirtueOSO
//
//  Created by Heriberto Prieto on 8/2/20.
//  Copyright © 2020 Heriberto Prieto. All rights reserved.
//

import UIKit

// MARK: - Message
struct Message {
    enum Sender {
        case me
        case you
    }
    public var sender: Sender
    public var message: String
}

// MARK: - ChatRoom
class ChatRoom: NSObject {
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    var message = ""
    var maxReadLength = 100000000
    
    weak var delegate: ChatRoomDelegate?
    
    // MARK: - Networking
    func sendMessage(_ message: String) {
        let data = "EIO=3&transport=websocket&sid=dHs9-AQhbbiZNQoZAAAB".data(using: .utf8)!
        
        self.message = message
        
        _ = data.withUnsafeBytes {
            guard let pointer = $0.baseAddress?.assumingMemoryBound(to: UInt8.self) else {
                print("Error joining chat")
                return
            }
            print("Message sent: \(message)")
            outputStream.write(pointer, maxLength: data.count)
        }
    }
    
    func stopChatSession() {
        inputStream.close()
        inputStream.open()
    }
    
    public func setupNetworkCommunication() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        CFStreamCreatePairWithSocketToHost(
            kCFAllocatorDefault,
            "localhost" as CFString,
            3000,
            &readStream,
            &writeStream
        )
        
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        
        inputStream.delegate = self
        
        inputStream.schedule(in: .current, forMode: .common)
        outputStream.schedule(in: .current, forMode: .common)
        
        inputStream.open()
        outputStream.open()
    }
}

// MARK: - Stream Delegate
extension ChatRoom: StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case .hasBytesAvailable:
          print("new message received")
            readAvailableBytes(stream: aStream as! InputStream)
        case .endEncountered:
            // print("new message received: \(aStream.streamError)")
            stopChatSession()
        case .errorOccurred:
            print("error occurred: \(aStream.streamError!)")
        case .hasSpaceAvailable:
          print("has space available")
        default:
          print("some other event...")
        }
    }
    
    private func readAvailableBytes(stream: InputStream) {
      let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: maxReadLength)
      while stream.hasBytesAvailable {
        let numberOfBytesRead = stream.read(buffer, maxLength: maxReadLength)
        if numberOfBytesRead < 0, let error = stream.streamError {
          print("Read Bytes Error:", error)
          break
        }
        if let message = processedMessageString(buffer: buffer, length: numberOfBytesRead) {
            print("message: \(message)")
            delegate?.received(message: message.message)
        }
      }
    }
    
    private func processedMessageString(buffer: UnsafeMutablePointer<UInt8>, length: Int) -> Message? {
        guard let message = String(bytesNoCopy: buffer, length: length, encoding: .utf8, freeWhenDone: true) else { return nil }
        print("Processing: \(message)")
        return Message(sender: .me, message: message)
    }
}

// MARK: - ChatRoomProtocol
protocol ChatRoomDelegate: class {
    func received(message: String)
}

class ChatRoomTableViewController: UIViewController {
    
    let chatRoom: ChatRoom = ChatRoom()
    
    // MARK: - Private Properties
    private var chatInputBarViewBottomLayoutConstraint: NSLayoutConstraint?
    private var chatInputBarViewBottomConstant: CGFloat = -30 {
        didSet {
            chatInputBarViewBottomLayoutConstraint?.constant = -chatInputBarViewBottomConstant
        }
    }
    
    // MARK: - Subviews
    private(set) lazy var navbar: SettingsNavigationBarView = {
        let view = SettingsNavigationBarView()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var chatInputBarView: ChatInputBarView = {
        let view = ChatInputBarView()
        view.sendButton.addTarget(
            self,
            action: #selector(handleSend),
            for: .touchUpInside
        )
        return view
    }()
    
    // MARK: - Handlers
    @objc private func handleSend() {
        chatRoom.sendMessage(chatInputBarView._text ?? "Nothing")
    }
    
    // MARK: - Notifications
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardNotification: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardFrame: CGRect = keyboardNotification.cgRectValue
        chatInputBarViewBottomConstant = keyboardFrame.height
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let `self` = self else { return }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        chatInputBarViewBottomConstant = 20
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let `self` = self else { return }
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeSubviews()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        chatRoom.setupNetworkCommunication()
        chatRoom.delegate = self
        chatRoom.sendMessage("Heriberto")
    }
    
    // MARK: - Initialize Subviews
    private func initializeSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(navbar)
        view.addSubview(tableView)
        view.addSubview(chatInputBarView)
        
        navbar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navbar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navbar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.backgroundColor = .red
        tableView.topAnchor.constraint(equalTo: navbar.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: chatInputBarView.topAnchor).isActive = true
        
        chatInputBarView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        chatInputBarView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        chatInputBarViewBottomLayoutConstraint = chatInputBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: chatInputBarViewBottomConstant)
        chatInputBarViewBottomLayoutConstraint?.isActive = true
    }
}

// MARK: - ChatRoomProtocol ChatRoomTableViewController
extension ChatRoomTableViewController: ChatRoomDelegate {
    func received(message: String) {
        print(message)
    }
}
