//
//  ViewController.swift
//  Assignment2
//
//  Created by Kobi Greene on 6/29/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import UIKit

class MainController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class Problem2ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var beforeCells = [[Bool]]()
    var afterCells = [[Bool]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Problem 2"
        print(beforeCells)
        for _ in 0..<10 {
            var subArray = [Bool]()
            for _ in 0..<10 {
                if arc4random_uniform(3) == 1 {
                    // set current cell to alive
                    subArray.append(true)
                }else{
                    subArray.append(false)
                }
                print(subArray)
            }
            beforeCells.append(subArray)
        }
        var totalAlive = 0
        for i in 0..<10 {
            for j in 0..<10 {
                if beforeCells[i][j].boolValue == true {
                    totalAlive += 1
                }
            }
        }
        textView.text = "Living cells:" + String(totalAlive)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonPressed(sender: AnyObject) {
        var totalAlive = 0
        var surrondingCellAliveCounter = 0
        //var surrondingCellDeadCounter = 0
        afterCells = beforeCells
        
        for y in 0..<10 {
            for x in 0..<10 {
                surrondingCellAliveCounter = 0
                //surrondingCellDeadCounter = 0
                var rightCell = (0,0)
                var leftCell = (0,0)
                var belowCell = (0,0)
                var aboveCell = (0,0)
                var diagonalDownLeft = (0,0)
                var diagonalDownRight = (0,0)
                var diagonalUpLeft = (0,0)
                var diagonalUpRIght = (0,0)
                if y == 0 {
                    aboveCell.0 = 9
                    diagonalUpLeft.0 = 9
                    diagonalUpRIght.0 = 9
                    rightCell.0 = 0
                    leftCell.0 = 0
                    belowCell.0 = 1
                    diagonalDownLeft.0 = 1
                    diagonalDownRight.0 = 1
                }else if y == 9 {
                    aboveCell.0 = 8
                    diagonalUpLeft.0 = 8
                    diagonalUpRIght.0 = 8
                    rightCell.0 = 9
                    leftCell.0 = 9
                    belowCell.0 = 0
                    diagonalDownLeft.0 = 0
                    diagonalDownRight.0 = 0
               
                }else {
                    aboveCell.0 = y - 1
                    diagonalUpLeft.0 = y - 1
                    diagonalUpRIght.0 = y - 1
                    rightCell.0 = y
                    leftCell.0 = y
                    belowCell.0 = y + 1
                    diagonalDownLeft.0 = y + 1
                    diagonalDownRight.0 = y + 1
                }
                if x == 0 {
                    aboveCell.1 = 0
                    diagonalUpLeft.1 = 9
                    diagonalUpRIght.1 = 1
                    rightCell.1 = 1
                    leftCell.1 = 9
                    belowCell.1 = 0
                    diagonalDownLeft.1 = 9
                    diagonalDownRight.1 = 1
                }else if x == 9{
                    aboveCell.1 = 9
                    diagonalUpLeft.1 = 8
                    diagonalUpRIght.1 = 0
                    rightCell.1 = 0
                    leftCell.1 = 8
                    belowCell.1 = 9
                    diagonalDownLeft.1 = 8
                    diagonalDownRight.1 = 0
                }else {
                    aboveCell.1 = x
                    diagonalUpLeft.1 = x - 1
                    diagonalUpRIght.1 = x + 1
                    rightCell.1 = x + 1
                    leftCell.1 = x - 1
                    belowCell.1 = x
                    diagonalDownLeft.1 = x - 1
                    diagonalDownRight.1 = x + 1
                }
                let surrondingCells = [afterCells[aboveCell.0][aboveCell.1],afterCells[diagonalUpLeft.0][diagonalUpLeft.1],afterCells[diagonalUpRIght.0][diagonalUpRIght.1],afterCells[rightCell.0][rightCell.1], afterCells[leftCell.0][leftCell.1], afterCells[belowCell.0][belowCell.1], afterCells[diagonalDownLeft.0][diagonalDownLeft.1],afterCells[diagonalDownRight.0][diagonalDownRight.1]]
                for cell in surrondingCells {
                    if cell.boolValue == true {
                        surrondingCellAliveCounter += 1
                    }else {
                         //surrondingCellDeadCounter += 1
                    }
                }
                switch afterCells[y][x].boolValue {
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
                    }else {
                        afterCells[y][x] = false
                    }
                }
                }
            }
        for i in 0..<10 {
            for j in 0..<10 {
                if afterCells[i][j].boolValue == true {
                    totalAlive += 1
                }
            }
        }
    
        textView.text = "Living cells:" + String(totalAlive)
    }
}

class Problem3ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Problem 3"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        textView.text = "Button Was Pressed!"
    }
    
    
}

class Problem4ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Problem 4"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        textView.text = "Button Was Pressed!"
    }
    
    
}



















