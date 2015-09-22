//
//  MainWindowController.swift
//  BusyApp
//
//  Created by Mattias Brand on 18/07/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    @IBOutlet weak var checkBox: NSButton!
    @IBOutlet weak var secureTextField: NSSecureTextField!
    @IBOutlet weak var revealTextField: NSTextField!
    @IBOutlet weak var showTickMarks: NSButton!
    @IBOutlet weak var hideTickMarks: NSButton!
    @IBOutlet weak var slider: NSSlider!
    @IBOutlet weak var sliderText: NSTextField!
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    @IBAction func onCheckedChanged(sender: NSButton) {
        if(sender.state == NSOnState) {
            checkBox.title = "Uncheck me"
        } else {
            checkBox.title = "Check me"
        }

    }
    
    @IBAction func revealButtonClicked(sender: NSButton) {
        revealTextField.stringValue = secureTextField.stringValue
    }
    
    @IBAction func tickMarkChanged(sender: NSButton) {
        if(sender.state == NSOnState) {
            if(sender.tag == 2) {
                slider.numberOfTickMarks = 10
            } else {
                slider.numberOfTickMarks = 0
            }
        }
    }
    
    var prevSliderValue: Double = 0
    
    @IBAction func sliderChanged(sender: NSSlider) {
        if(sender.doubleValue > prevSliderValue) {
            sliderText.stringValue = "Slider goes up"
        } else {
            sliderText.stringValue = "Slider goes down"
        }
        
        prevSliderValue = sender.doubleValue
    }
}
