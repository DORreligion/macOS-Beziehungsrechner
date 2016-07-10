//
//  ViewController.swift
//  Beziehungsrechner
//
//  Created by Lukas Schramm on 16-07-10.
//  Copyright © 2016 Cappricorn. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTextFieldDelegate {

    @IBOutlet weak var name1: NSTextField!
    @IBOutlet weak var name2: NSTextField!
    @IBOutlet weak var progressbar: NSProgressIndicator!
    @IBOutlet weak var outletLabel: NSTextField!
    @IBOutlet weak var calculateButton: NSButton!
    
    @IBAction func calculate(_ sender: NSButton) {
        let n1 = name1.stringValue.alphabetic.stringToDOR()
        let n2 = name2.stringValue.alphabetic.stringToDOR()
        name1.stringValue = n1
        name2.stringValue = n2
        
        let calc = CalcRelation(names: [n1, n2])
        progressbar.doubleValue = Double(calc.getRelationRate())
        progressbar.toolTip = "\(calc.getRelationRate())% Beziehungsrate"
        
        outletLabel.stringValue = "\(n1) und \(n2) passen zu \(calc.getRelationRate()) % zusammen."
    }
    
    override func controlTextDidChange(_ obj: Notification) {
        let n1 = name1.stringValue.alphabetic.stringToDOR()
        let n2 = name2.stringValue.alphabetic.stringToDOR()
        
        if n1 != "" && n2 != "" {
            calculateButton.isEnabled = true
        } else {
            calculateButton.isEnabled = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calculateButton.isEnabled = false
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}
