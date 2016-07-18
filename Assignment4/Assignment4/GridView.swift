//
//  GridView.swift
//  Assignment3
//
//  Created by Kobi Greene on 7/10/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import UIKit

var afterCells = [[CellState]]()
var sGrid = [[CellState]]()
@IBDesignable
class GridView: UIView {
    @IBInspectable var rows: Int = 10 {
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var cols: Int = 10{
        didSet{
            setNeedsDisplay()
        }
    
    }
    @IBInspectable var livingColor: UIColor = UIColor.greenColor()
    @IBInspectable var emptyColor: UIColor = UIColor.grayColor()
    @IBInspectable var bornColor: UIColor = UIColor.blueColor()
    @IBInspectable var diedColor: UIColor = UIColor.redColor()
    @IBInspectable var gridColor: UIColor = UIColor.blackColor()
    @IBInspectable var gridWidth: CGFloat = 30.0

    
    var lineRows: Int!
    var lineCols: Int!
    var width: CGFloat!
    var height: CGFloat!
    var maxCol: Int!
    var maxRows: Int!
    override func didMoveToWindow() {
          //print(neighbors((y: 8, x: 5)))
        //Init the grid Cells to empty 
        for _ in 0..<rows {
            var subArray = [CellState]()
            for _ in 0..<cols {
                var cell = CellState.Empty {
                    didSet {
                        setNeedsDisplay()
                    }
                }
                subArray.append(cell)
                
            }
            sGrid.append(subArray)
            afterCells.append(subArray)
        }
    }
    override func drawRect(rect: CGRect) {
        maxCol = cols - 1
        maxRows = rows - 1
        let gridPath = UIBezierPath()
        gridPath.lineWidth = gridWidth
        lineRows = rows + 1
        lineCols = cols + 1
        width = rect.width / CGFloat(cols)
        height = rect.height / CGFloat(rows)
        //Drawing the grid
        for i in 0..<lineRows{
            gridPath.moveToPoint(CGPoint(x: bounds.origin.x, y: bounds.origin.y + height * CGFloat(i)))
            gridPath.addLineToPoint(CGPoint(x: bounds.origin.x + width * CGFloat(cols) , y: bounds.origin.y + height * CGFloat(i)))
            gridColor.setStroke()
            gridPath.stroke()
        }
        for i in 0..<lineCols {
            gridPath.moveToPoint(CGPoint(x: bounds.origin.x + width * CGFloat(i), y: bounds.origin.y))
            gridPath.addLineToPoint(CGPoint(x: bounds.origin.x + width * CGFloat(i) , y: bounds.origin.y + height * CGFloat(cols)))
            gridColor.setStroke()
            gridPath.stroke()
        }
        for y in 0..<rows{
            for x in 0..<cols {
                //Draws circle
                let center = findCenter(y, col: x, theWidth: width, theHeight: height)
                //print(center)
                let radius = (width / 2) - 0.5
                let arcWidth: CGFloat = 0.1
                let startAngle: CGFloat = 0
                let endAngle: CGFloat = 2 * CGFloat(M_PI)
                let oval = UIBezierPath(arcCenter: center,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
                
                oval.lineWidth = arcWidth
                //Changing color for circle based on status
                switch sGrid[y][x]{
                    case .Living:
                        livingColor.setFill()
                        livingColor.setStroke()
                    case .Empty:
                        emptyColor.setFill()
                        emptyColor.setStroke()
                    case .Born:
                        bornColor.setFill()
                        bornColor.setStroke()
                    case .Died:
                        diedColor.setFill()
                        diedColor.setStroke()
                }
                oval.fill()
                oval.stroke()
            }
        }
        
    }
    //finding the center of each cell to draw the circele
    func findCenter(row: Int, col: Int, theWidth: CGFloat, theHeight: CGFloat) -> CGPoint{
        let x1 = CGFloat(col) * theWidth
        let y1 = CGFloat(row) * theHeight
        let x2 = x1 + theWidth
        let y2 = y1 + theHeight
        return CGPoint(x: (x1 + x2) / 2, y: (y1 + y2) / 2)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var rect = CGRect(x:0, y: 0, width: width, height: height)
        for touch in touches {
            //print("Hello")
            for y in 0..<rows {
                for x in 0..<cols {
                    // creates rect that moves to check which cell was touched
                    rect.origin = CGPoint(x: 0.0 + width * CGFloat(x), y: 0 + height * CGFloat(y))
                    if CGRectContainsPoint(rect, touch.locationInView(self)){
                        sGrid[y][x] = CellState.toggle(sGrid[y][x])
                       // AppDelegate().engineSingleton.grid = grid
                        setNeedsDisplay()
                    }
                }
            }
        }
    }
    

}




