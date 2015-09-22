//
//  MainWindowController.swift
//  AspectRatio
//
//  Created by Mattias Brand on 25/07/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Cocoa
import CoreGraphics

class MainWindowController: NSWindowController, NSWindowDelegate {

    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    
    func windowWillResize(sender: NSWindow, toSize frameSize: NSSize) -> NSSize {
        var newSize: NSSize
        if fabs(sender.frame.width - frameSize.width) >= 1.0 {
            newSize = NSSize(width: frameSize.width, height: (9*frameSize.width) / 16)
        } else {
            newSize = NSSize(width: (16*frameSize.height)/9, height: frameSize.height)
        }
        
        CGWarpMouseCursorPosition(CGPoint(x: sender.frame.origin.x + newSize.width, y: sender.frame.origin.y + newSize.height))
        return newSize
    }

}
