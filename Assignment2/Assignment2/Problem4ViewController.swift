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
        var totalAlive = 0
        var surrondingCellAliveCounter = 0
        
        for y in range {
            for x in range {
                surrondingCellAliveCounter = 0
                let neighborCells = neighbors((y: y, x: x))
                for cell in neighborCells {
                    if afterCells[cell.0][cell.1].boolValue == true {
                        surrondingCellAliveCounter += 1
                    }
                }
                // switching on the value of the current cell
                switch afterCells[y][x].boolValue {
                // Checking for the rules for the game of life
                case true:
                    if surrondingCellAliveCounter < 2 {
                        afterCells[y][x] = false
                    }else if surrondingCellAliveCounter == 2 || surrondingCellAliveCounter == 3 {
                        afterCells[y][x] = true
                    }else if surrondingCellAliveCounter > 3{
                        afterCells[y][x] = false
                    }
                case false:
                    if surrondingCellAliveCounter == 3 {
                        afterCells[y][x] = true
                    }
                }
            }
        }
        //calculates total number of alive cells
        totalAlive = calculateTotalAlive(afterCells)
        
        textView.text = "Living cells:" + String(totalAlive)
    }
        }
    
    
    

