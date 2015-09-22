//
//  Document.swift
//  RaiseMan
//
//  Created by Mattias Brand on 26/07/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Cocoa

private var KVOContext: Int = 0

class Document: NSDocument, NSWindowDelegate {

    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet weak var arrayController: NSArrayController!
    
    var employees: [Employee] = [] {
        willSet {
            for employee in employees {
                stopObservingEmployee(employee)
            }
        }
        didSet {
            for employee in employees {
                startObservingEmployee(employee)
            }
        }
    }
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }

    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
    }

    override class func autosavesInPlace() -> Bool {
        return true
    }

    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }
    
    override func dataOfType(typeName: String, error outError: NSErrorPointer) -> NSData? {
        tableView.window?.endEditingFor(nil)
        return NSKeyedArchiver.archivedDataWithRootObject(employees)
    }
    
    override func readFromData(data: NSData, ofType typeName: String, error outError: NSErrorPointer) -> Bool {
        println("About to read data of type \(typeName)")
        employees = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Employee]
        return true;
    }
    
    // MARK: - Accessors
    func insertObject(employee: Employee, inEmployeesAtIndex index:Int) {
        println("adding \(employee) to the employees array")
        
        let undo: NSUndoManager = undoManager!
        undo.prepareWithInvocationTarget(self).removeObjectFromEmployeesAtIndex(employees.count)
        
        if !undo.undoing {
            undo.setActionName("Add Person")
        }
        
        employees.append(employee)
    }
    
    func removeObjectFromEmployeesAtIndex(index: Int) {
        let employee: Employee = employees[index]
        
        println("removing \(employee) from the employees array")
        
        let undo: NSUndoManager = undoManager!
        undo.prepareWithInvocationTarget(self).insertObject(employee, inEmployeesAtIndex: index)
        
        if !undo.undoing {
            undo.setActionName("Remove Person")
        }
        
        employees.removeAtIndex(index)
    }
    
    // MARK: - Key Value Observing
    func startObservingEmployee(employee: Employee) {
        employee.addObserver(self, forKeyPath: "name", options: .Old, context: &KVOContext)
        employee.addObserver(self, forKeyPath: "raise", options: .Old, context: &KVOContext)
    }
    
    func stopObservingEmployee(employee: Employee) {
        employee.removeObserver(self, forKeyPath: "name", context: &KVOContext)
        employee.removeObserver(self, forKeyPath: "raise", context: &KVOContext)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if context != &KVOContext {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
            return
        }
        
        var oldValue: AnyObject? = change[NSKeyValueChangeOldKey]
        if oldValue is NSNull {
            oldValue = nil
        }
        
        let undo: NSUndoManager = undoManager!
        println("oldvalue=\(oldValue)")
        undo.prepareWithInvocationTarget(object).setValue(oldValue, forKeyPath: keyPath)
    }
    
    // MARK: - NSWindowDelegate
    func windowWillClose(notification: NSNotification) {
        employees = []
    }
    
    // MARK: - Actions
    @IBAction func addEmployee(sender: NSButton) {
        let windowController = windowControllers[0] as! NSWindowController
        let window = windowController.window!
        let endedEditing = window.makeFirstResponder(window)
        if !endedEditing {
            println("Unable to end editing")
            return
        }
        
        let undo: NSUndoManager = undoManager!
        
        if undo.groupingLevel > 0 {
            undo.endUndoGrouping()
            undo.beginUndoGrouping()
        }
        
        let employee = arrayController.newObject() as! Employee
        arrayController.addObject(employee)
        arrayController.rearrangeObjects()
        let sortedEmployees = arrayController.arrangedObjects as! [Employee]
        let row = find(sortedEmployees, employee)!
        println("starting edit of \(employee) in row \(row)")
        tableView.editColumn(0, row: row, withEvent: nil, select: true)
    }
    
    @IBAction func removeEmployees(sender: NSButton) {
        let selectedPeople: [Employee] = arrayController.selectedObjects as! [Employee]
        let alert = NSAlert()
        if(selectedPeople.count > 1) {
            alert.messageText = "Do you really want to remove these people?"
            alert.informativeText = "\(selectedPeople.count) will be removed."
        } else {
            alert.messageText = "Do you really want to remove this person?"
            alert.informativeText = "\(selectedPeople[0].name!) will be removed."
        }
        
        alert.addButtonWithTitle("Cancel")
        alert.addButtonWithTitle("Remove")
        alert.addButtonWithTitle("Keep but with no raise")
        let window = sender.window!
        
        alert.beginSheetModalForWindow(window, completionHandler: { (response) -> Void in
            switch response {
            case NSAlertSecondButtonReturn:
                self.arrayController.remove(nil)
            case NSAlertThirdButtonReturn:
                for emp: Employee in self.arrayController.selectedObjects as! [Employee]! {
                    emp.setValue(0, forKey: "raise")
                }
                break
            default:break
            }
        })
    }
}