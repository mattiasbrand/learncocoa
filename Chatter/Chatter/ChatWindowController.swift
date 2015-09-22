//
//  ChatWindowController.swift
//  Chatter
//
//  Created by Mattias Brand on 16/09/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Cocoa

private let ChatWindowControllerDidSendMessageNotification = "brand.ChatWindowControllerDidSendMessageNotification"
private let ChatWindowControllerMessageKey = "brand.ChatWindowControllerMessageKey"
private let ChatWindowControllerUserNameKey = "brand.ChatWindowControllerUserNameKey"

class ChatWindowController: NSWindowController {
    
    dynamic var log: NSAttributedString = NSAttributedString(string: "")
    dynamic var message: String?
    @IBOutlet weak var userName: NSTextField!
    
    @IBOutlet var textView: NSTextView! // NSTextView does not support weak reference
    
    override func windowDidLoad() {
        super.windowDidLoad()

        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: Selector("receiveDidSendMessageNotification:"), name: ChatWindowControllerDidSendMessageNotification, object: nil)
        
    }
    
    deinit {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Actions
    
    @IBAction func send(sender: NSButton) {
        sender.window?.endEditingFor(nil)
        if let message = message {
            let userInfo = [ChatWindowControllerMessageKey : message, ChatWindowControllerUserNameKey : userName.stringValue]
            let notificationCenter = NSNotificationCenter.defaultCenter()
            notificationCenter.postNotificationName(ChatWindowControllerDidSendMessageNotification, object: self, userInfo: userInfo)
        }
        message = ""
    }
    
    // MARK: - Lifecycle
    
    override var windowNibName: String {
        return "ChatWindowController"
    }
    
    // MARK: - Notifications
    
    func receiveDidSendMessageNotification(note: NSNotification) {
        let mutableLog = log.mutableCopy() as! NSMutableAttributedString
        
        if log.length > 0 {
            mutableLog.appendAttributedString(NSAttributedString(string: "\n"))
        }
        
        let userInfo = note.userInfo as! [String: String]
        let message = userInfo[ChatWindowControllerMessageKey]!
        let userName = userInfo[ChatWindowControllerUserNameKey]!

        let logLine = NSMutableAttributedString(string: userName + ": " + message)
        
        if(note.object! as! NSObject == self) {
            let attributes = [NSForegroundColorAttributeName: NSColor.blueColor()]
            logLine.addAttributes(attributes, range: NSMakeRange(0, logLine.length))
        }

        mutableLog.appendAttributedString(logLine)
        
        log = mutableLog.copy() as! NSAttributedString
        
        textView.scrollRangeToVisible(NSRange(location: log.length, length: 0))
        
    }
}
