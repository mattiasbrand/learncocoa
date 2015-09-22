//
//  MainWindowController.swift
//  Thermostat
//
//  Created by Mattias Brand on 25/07/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    dynamic var temperature = 68
    dynamic var isOn = true
    
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func makeWarmer(sender: NSButton) {
        temperature++
    }
    @IBAction func makeCooler(sender: NSButton) {
        temperature--
    }
}
