//
//  MainWindowController.swift
//  RGBWell
//
//  Created by Mattias Brand on 12/07/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    dynamic var r = 0.5
    dynamic var g = 0.5
    dynamic var b = 0.5
    let a = 1.0
    dynamic var c: NSColor {
        return NSColor(calibratedRed: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: CGFloat(a))
    }
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    class func keyPathsForValuesAffectingC() -> NSSet {
        return Set(["r", "g", "b"])
    }
}
