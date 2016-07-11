//
//  GridView.swift
//  Assignment3
//
//  Created by Kobi Greene on 7/10/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import UIKit


var grid = [[CellState]]()
@IBDesignable
class GridView: UIView {
    @IBInspectable var rows: Int = 20 {
        didSet{
            setNeedsDisplay()
        }
    }
    @IBInspectable var cols: Int = 20{
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
          print(neighbors((y: 15, x: 11)))
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
            grid.append(subArray)
        }
    }
    override func drawRect(rect: CGRect) {
        maxCol = cols - 1
        maxRows = rows - 1
        _ = UIBezierPath(ovalInRect: rect)
        let gridPath = UIBezierPath()
        gridPath.lineWidth = gridWidth
        lineRows = rows + 1
        lineCols = cols + 1
        width = rect.width / CGFloat(cols)
        height = rect.height / CGFloat(rows)
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
                let center = findCenter(y, col: x, theWidth: width, theHeight: height)
                //print(center)
                let radius = width / 2
                let arcWidth: CGFloat = 2
                let startAngle: CGFloat = 0
                let endAngle: CGFloat = 2 * CGFloat(M_PI)
                let oval = UIBezierPath(arcCenter: center,
                                        radius: radius,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true)
                
                oval.lineWidth = arcWidth
                switch grid[y][x].description(){
                    case "Living":
                        livingColor.setFill()
                        livingColor.setStroke()
                    case "Empty":
                        emptyColor.setFill()
                        emptyColor.setStroke()
                    case "Born":
                        bornColor.setFill()
                        bornColor.setStroke()
                    case "Died":
                        diedColor.setFill()
                        diedColor.setStroke()
                default:
                    emptyColor.setFill()
                    emptyColor.setStroke()
                }
                oval.fill()
                oval.stroke()
            }
        }
        
    }
    func findCenter(row: Int, col: Int, theWidth: CGFloat, theHeight: CGFloat) -> CGPoint{
        let x1 = CGFloat(col) * theWidth
        let y1 = CGFloat(row) * theHeight
        let x2 = x1 + theWidth
        let y2 = y1 + theHeight
        return CGPoint(x: (x1 + x2) / 2, y: (y1 + y2) / 2)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var rect = CGRect(x:0, y: 0, width: width, height: height)
        print(grid)
        print(width)
        for touch in touches {
            //print("Hello")
                for y in 0..<rows {
                    for x in 0..<cols {
                        rect.origin = CGPoint(x: 0.0 + width * CGFloat(x), y: 0 + height * CGFloat(y))
                        if CGRectContainsPoint(rect, touch.locationInView(self)){
                            print("touched")
                            print(y)
                            print(x)
                            print(grid[y][x])
                            grid[y][x] = CellState.toggle(grid[y][x])
                            print(grid[y][x])
                            //grid[y][x].
                            setNeedsDisplay()
                    }
                }
            }
        }
    }
    
    func neighbors(cell: (y: Int, x: Int) ) -> Array<(Int,Int)>{
    
        maxCol = cols - 1
        maxRows = rows - 1
        var rightCell = (0,0)
        var leftCell = (0,0)
        var belowCell = (0,0)
        var aboveCell = (0,0)
        var diagonalDownLeft = (0,0)
        var diagonalDownRight = (0,0)
        var diagonalUpLeft = (0,0)
        var diagonalUpRIght = (0,0)
        //Checking for the cells surronding the given current cell
        if cell.y == 0 {
            aboveCell.0 = maxRows
            diagonalUpLeft.0 = maxRows
            diagonalUpRIght.0 = maxRows
            rightCell.0 = 0
            leftCell.0 = 0
            belowCell.0 = 1
            diagonalDownLeft.0 = 1
            diagonalDownRight.0 = 1
        }else if cell.y == maxRows {
            aboveCell.0 = maxRows - 1
            diagonalUpLeft.0 = maxRows - 1
            diagonalUpRIght.0 = maxRows - 1
            rightCell.0 = maxRows
            leftCell.0 = maxRows
            belowCell.0 = 0
            diagonalDownLeft.0 = 0
            diagonalDownRight.0 = 0
            
        }else {
            aboveCell.0 = cell.y - 1
            diagonalUpLeft.0 = cell.y - 1
            diagonalUpRIght.0 = cell.y - 1
            rightCell.0 = cell.y
            leftCell.0 = cell.y
            belowCell.0 = cell.y + 1
            diagonalDownLeft.0 = cell.y + 1
            diagonalDownRight.0 = cell.y + 1
        }
        if cell.x == 0 {
            aboveCell.1 = 0
            diagonalUpLeft.1 = maxCol
            diagonalUpRIght.1 = 1
            rightCell.1 = 1
            leftCell.1 = maxCol
            belowCell.1 = 0
            diagonalDownLeft.1 = maxCol
            diagonalDownRight.1 = 1
        }else if cell.x == maxCol{
            aboveCell.1 = maxCol
            diagonalUpLeft.1 = maxCol - 1
            diagonalUpRIght.1 = 0
            rightCell.1 = 0
            leftCell.1 = maxCol - 1
            belowCell.1 = maxCol
            diagonalDownLeft.1 = maxCol - 1
            diagonalDownRight.1 = 0
        }else {
            aboveCell.1 = cell.x
            diagonalUpLeft.1 = cell.x - 1
            diagonalUpRIght.1 = cell.x + 1
            rightCell.1 = cell.x + 1
            leftCell.1 = cell.x - 1
            belowCell.1 = cell.x
            diagonalDownLeft.1 = cell.x - 1
            diagonalDownRight.1 = cell.x + 1
        }
        // creates an array of all cells surronding current cell
        let surrondingCells = [aboveCell, diagonalUpLeft, diagonalUpRIght, rightCell, leftCell, belowCell, diagonalDownLeft, diagonalDownRight]
        return surrondingCells
    }
    
    func step2(cellA: Array<Array<CellState>>) -> Array<Array<CellState>>{
        maxCol = cols - 1
        maxRows = rows - 1
        var surrondingCellAliveCounter = 0
        var cellArr = cellA
        for y in 0...maxRows {
            for x in 0...maxCol {
                surrondingCellAliveCounter = 0
                let neighborCells = neighbors((y: y, x: x))
                for cell in neighborCells {
                    if cellArr[cell.0][cell.1].description() == "Living" || cellArr[cell.0][cell.1].description() == "Born" {
                        surrondingCellAliveCounter += 1
                    }
                }
                // switching on the value of the current cell
                switch cellArr[y][x].rawValue {
                // Checking for the rules for the game of life
                case "Living", "Born":
                    if surrondingCellAliveCounter < 2 {
                        cellArr[y][x] = CellState.toggle(cellArr[y][x])
                    }else if surrondingCellAliveCounter == 2 || surrondingCellAliveCounter == 3 {
                        cellArr[y][x] = cellArr[y][x]
                    }else if surrondingCellAliveCounter > 3{
                        cellArr[y][x] = CellState.toggle(cellArr[y][x])
                    }
                case "Died", "Empty":
                    if surrondingCellAliveCounter == 3 {
                        cellArr[y][x] = CellState.toggle(cellArr[y][x])
                    }
                    else {
                        cellArr[y][x] = cellArr[y][x]
                    }
                default:
                    cellArr[y][x] = cellArr[y][x]
                }
            }
        }
        return cellArr
    }
    func iterateCells() {
        print(grid)
        afterCells = step2(grid)
        grid = afterCells
        setNeedsDisplay()
    }

}




