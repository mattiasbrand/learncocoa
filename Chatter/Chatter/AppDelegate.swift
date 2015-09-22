//
//  AppDelegate.swift
//  Chatter
//
//  Created by Mattias Brand on 16/09/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var windowControllers: [ChatWindowController] = []
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        addWindowController()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    // Mark: - Helpers
    
    func addWindowController() {
        let windowController = ChatWindowController()
        windowController.showWindow(self)
        windowControllers.append(windowController)
    }

    func applicationDidResignActive(notification: NSNotification) {
        NSBeep()
    }
    
    // Mark: - Actions
    @IBAction func displayNewWindow(sender: NSMenuItem) {
        addWindowController()
    }
}

