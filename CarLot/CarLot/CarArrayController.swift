//
//  CarArrayController.swift
//  CarLot
//
//  Created by Mattias Brand on 12/09/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Cocoa

class CarArrayController: NSArrayController {
    override func newObject() -> AnyObject {
        let newObj = super.newObject() as! NSObject
        let now = NSDate()
        newObj.setValue(now, forKey: "datePurchased")
        return newObj
    }

}
