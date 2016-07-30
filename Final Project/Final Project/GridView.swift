//
//  GridView.swift
//  ProjectPrototype
//
//  Created by Van Simmons on 7/23/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit

@IBDesignable

class GridView: UIView {
    
    @IBInspectable var rows: Int = 20{
        didSet{
            //resetgrid
            StandardEngine.sharedEngine.rows = rows
            print(rows)
            //self.setNeedsDisplay()
        }
    }
    @IBInspectable var cols: Int = 20{
        didSet{
            //reset grid
            StandardEngine.sharedEngine.cols = cols
            print(cols)
            //self.setNeedsDisplay()
        }
        
    }
    @IBInspectable var livingColor: UIColor = UIColor.greenColor()
    @IBInspectable var emptyColor: UIColor = UIColor.grayColor()
    @IBInspectable var bornColor: UIColor = UIColor.blueColor()
    @IBInspectable var diedColor: UIColor = UIColor.redColor()
    @IBInspectable var gridColor: UIColor = UIColor.blackColor()
    @IBInspectable var gridWidth: CGFloat = 30.0
    
    var points: Array<(Int,Int)> {
        get {
            var array = [(Int,Int)]()
            for y in 0..<rows {
                for x in 0..<cols {
                    if StandardEngine.sharedEngine[y,x].isLiving() {
                        array.append((y,x))
                    }
                }
            }
            return array
        }
        set {
            for y in 0..<rows {
                for x in 0..<cols {
                    for point in points {
                        if y == point.0 && x == point.1{
                            StandardEngine.sharedEngine.grid[point.0, point.1] = CellState.Alive
                        }else {
                            StandardEngine.sharedEngine.grid[y,x] = CellState.Empty
                        }
                }
            }
        }
        }
    }
    
    var lineRows: Int!
    var lineCols: Int!
    var width: CGFloat!
    var height: CGFloat!
    var maxCol: Int!
    var maxRows: Int!
    var engine = StandardEngine.sharedEngine
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if rect.size.width <= self.frame.width / 2 {
            let newRow = Int(ceil(rect.origin.y / height))
            let newCol = Int(ceil(rect.origin.x / width))
            let center = findCenter(newRow, col: newCol, theWidth: width, theHeight: height)
            let radius = (width / 2) - 0.5
            let arcWidth: CGFloat = 0.1
            let startAngle: CGFloat = 0
            let endAngle: CGFloat = 2 * CGFloat(M_PI)
            let gridPath = UIBezierPath()
            gridPath.lineWidth = gridWidth
            gridPath.moveToPoint(CGPoint(x: rect.origin.x, y: rect.origin.y))
            gridPath.addLineToPoint(CGPoint(x: rect.origin.x + width , y: rect.origin.y + height ))
            gridColor.setStroke()
            gridPath.stroke()
            gridPath.moveToPoint(CGPoint(x: rect.origin.x + width, y: rect.origin.y))
            gridPath.addLineToPoint(CGPoint(x: rect.origin.x + width , y: rect.origin.y + height))
            gridColor.setStroke()
            gridPath.stroke()
            print(rect.origin.y)
            print(rect.origin.x)
            print(newRow)
            print(newCol)
            print(width)
            print(height)
            let oval = UIBezierPath(arcCenter: center,
                                    radius: radius,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
            //Changing color for circle based on status
            oval.lineWidth = arcWidth
            switch engine.grid.cells[newRow*cols+newCol].state{
            case .Alive:
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
        }else {
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
                switch engine.grid.cells[y*cols+x].state{
                case .Alive:
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
                        if engine.grid[y,x].isLiving() {
                            engine.grid.cells[y*cols+x].state = CellState.Empty
                        }else {
                            engine.grid.cells[y*cols+x].state = CellState.Alive
                        }
                        
                        setNeedsDisplayInRect(rect)
                    }
                }
            }
        }
    }
    


}
