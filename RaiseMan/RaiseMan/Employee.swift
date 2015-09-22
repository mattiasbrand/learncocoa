//
//  Employee.swift
//  RaiseMan
//
//  Created by Mattias Brand on 26/07/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Foundation

class Employee : NSObject, NSCoding {
    var name: String? = "New Employee"
    var raise: Float = 0.5
    
    override init() {
        super.init()
    }
    
    func validateRaise(raiseNumberPointer: AutoreleasingUnsafeMutablePointer<NSNumber?>, error outError: NSErrorPointer) -> Bool {
        let raiseNumber = raiseNumberPointer.memory
        if raiseNumber == nil {
            let domain = "UserInputValidationErrorDomain"
            let code = 0
            let userInfo = [NSLocalizedDescriptionKey : "An employee's raise must be a number."]
            outError.memory = NSError(domain: domain, code: code, userInfo: userInfo)
            return false
        } else {
            return true
        }
    }
    
    // MARK: - NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let name = name {
            aCoder.encodeObject(name, forKey: "name")
        }
        aCoder.encodeFloat(raise, forKey: "raise")
    }
    
    required init(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String?
        raise = aDecoder.decodeFloatForKey("raise")
        super.init()
    }
}
