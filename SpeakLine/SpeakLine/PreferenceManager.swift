//
//  PreferenceManager.swift
//  SpeakLine
//
//  Created by Mattias Brand on 12/09/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Cocoa

private let activeVoiceKey = "activeVoice"
private let activeTextKey = "activeText"

class PreferenceManager {
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    private let defaults = [ activeVoiceKey: NSSpeechSynthesizer.defaultVoice(), activeTextKey: "Tell me what to say"]
    
    init() {
        registerDefaultPreferences()
    }
    
    func reset() {
  //      userDefaults.removeObjectForKey(activeVoiceKey)
//        userDefaults.removeObjectForKey(activeTextKey)
        //userDefaults.didChangeValueForKey(activeVoiceKey)
        //userDefaults.didChangeValueForKey(activeTextKey)
        userDefaults.setObject(defaults[activeVoiceKey], forKey: activeVoiceKey)
        userDefaults.setObject(defaults[activeTextKey], forKey: activeTextKey)
    }
    
    func registerDefaultPreferences() {
        userDefaults.registerDefaults(defaults)
        NSUserDefaultsController.sharedUserDefaultsController().initialValues = defaults
    }
    
    var activeVoice: String? {
        set (newActiveVoice) {
            userDefaults.setObject(newActiveVoice, forKey: activeVoiceKey)
        }
        get {
            return userDefaults.objectForKey(activeVoiceKey) as? String
        }
    }
    
    var activeText: String? {
        set (newActiveText) {
            userDefaults.setObject(newActiveText, forKey: activeTextKey)
        }
        get {
            return userDefaults.objectForKey(activeTextKey) as? String
        }
    }
}
