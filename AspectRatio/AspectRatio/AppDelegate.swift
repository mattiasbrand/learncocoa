//
//  AppDelegate.swift
//  AspectRatio
//
//  Created by Mattias Brand on 25/07/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController: MainWindowController?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let mainWindowController = MainWindowController()
        mainWindowController.showWindow(self)
        self.mainWindowController = mainWindowController
    }
}

