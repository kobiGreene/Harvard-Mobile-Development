//
//  Problem4ViewController.swift
//  Assignment2
//
//  Created by Kobi Greene on 7/3/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import UIKit

class Problem4ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var beforeCells = [[Bool]]()
    var afterCells = [[Bool]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Problem 4"
        
        beforeCells = step(beforeCells)
        var totalAlive = 0
        totalAlive = calculateTotalAlive(beforeCells)
        afterCells = beforeCells
        textView.text = "Living cells:" + String(totalAlive)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        //calculates total number of alive cells
        var totalAlive = 0
        afterCells = step2(afterCells)
        totalAlive = calculateTotalAlive(afterCells)
        
        textView.text = "Living cells:" + String(totalAlive)
    }
        }
    
    
    

