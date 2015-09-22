//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by Mattias Brand on 20/07/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate {
    
    let speechSynth = NSSpeechSynthesizer()
    let voices = NSSpeechSynthesizer.availableVoices() as! [String]
    let preferenceManager = PreferenceManager()
    
    var isStarted: Bool = false {
        didSet {
            updateButtons()
        }
    }
    
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        updateButtons()
        super.windowDidLoad()
        speechSynth.delegate = self

        //println(voices.map({v in self.voiceNameForIdentifier(v)!}))
        
//        let defaultVoice = preferenceManager.activeVoice!
//        if let defaultRow = find(voices, defaultVoice) {
//            let indices = NSIndexSet(index: defaultRow)
//            tableView.selectRowIndexes(indices, byExtendingSelection: false)
//            tableView.scrollRowToVisible(defaultRow)
//        }
    }
    
    func updateButtons() {
        if isStarted {
            speakButton.enabled = false
            stopButton.enabled = true
        } else {
            speakButton.enabled = true
            stopButton.enabled = false
        }
    }
    
    func voiceNameForIdentifier(identifier: String) -> String? {
        if let attributes = NSSpeechSynthesizer.attributesForVoice(identifier) {
            return attributes[NSVoiceName] as? String
        } else {
            return nil
        }
    }
    
    // MARK: - NSTableViewDelegate
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let row = tableView.selectedRow
        if row == -1 {
            speechSynth.setVoice(nil)
            return
        }
        let voice = voices[row]
        speechSynth.setVoice(voice)
        //preferenceManager.activeVoice = voice
    }
    
    // MARK: - NSWindowDelegate
    func windowShouldClose(sender: AnyObject) -> Bool {
        return !isStarted
    }
    
    // MARK: - NSSpeechSynthesizerDelegate
    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isStarted = false
        println("finishedSpeaking=\(finishedSpeaking)")
    }
    
    // MARK: - Outlets
    @IBOutlet weak var speakText: NSTextField!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var userDefaults: NSUserDefaultsController!
    @IBOutlet weak var resetButton: NSButton!
    
    // MARK: - Action methods
    @IBAction func stop(sender: NSButton) {
        speechSynth.stopSpeaking()
    }
    
    @IBAction func speak(sender: NSButton) {
        let string = speakText.stringValue
        if string.isEmpty {
            println("String from \(speakText) is empty")
        } else {
            speechSynth.startSpeakingString(speakText.stringValue)
            isStarted = true
        }
    }
    
    @IBAction func reset(sender: NSButton) {
        userDefaults.revertToInitialValues(self)
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return voices.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let voice = voices[row]
        let voiceName = voiceNameForIdentifier(voice)
        return voiceName
    }
}
