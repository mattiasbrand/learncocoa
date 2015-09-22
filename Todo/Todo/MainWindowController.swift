//
//  MainWindowController.swift
//  Todo
//
//  Created by Mattias Brand on 25/07/15.
//  Copyright (c) 2015 Mattias Brand. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSTableViewDataSource {

    @IBOutlet weak var newTodo: NSTextField!
    @IBOutlet weak var addTodoButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    var todos = [String]()
    
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    @IBAction func addTodoClicked(sender: NSButton) {
        addTodo()
    }
    @IBAction func newTodoChanged(sender: NSTextField) {
        addTodo()
    }
    @IBAction func todoEdited(sender: NSTextField) {
        let rowNumber = tableView.selectedRow
        todos[rowNumber] = sender.stringValue
    }

    func addTodo() {
        if newTodo.stringValue == "" { return }
        todos.append(newTodo.stringValue)
        newTodo.stringValue = ""
        tableView.reloadData()
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return todos.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        return todos[row]
    }
    
}
