//
//  GeneratePassword.swift
//  RandomPassword
//
//  Created by Mattias Brand on 10/07/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Foundation

private let characters = Array("0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVXYZ")

func generateRandomString(length: Int) -> String {
    var string = ""
    
    for index in 0..<length {
        string.append(generateRandomCharacter())
    }
    
    return string
}

func generateRandomCharacter() -> Character {
    let index = Int(arc4random_uniform(UInt32(characters.count)))
    let character = characters[index]
    return character
}