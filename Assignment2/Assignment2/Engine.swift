//
//  Engine.swift
//  Assignment2
//
//  Created by Kobi Greene on 7/3/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import Foundation

func step(cellsArr: Array<Array<Bool>>) -> Array<Array<Bool>> {
    var beforeCells = cellsArr
    for _ in range {
        var subArray = [Bool]()
        for _ in range {
            if arc4random_uniform(3) == 1 {
                // set current cell to alive
                subArray.append(true)
            }else{
                subArray.append(false)
            }
        }
        beforeCells.append(subArray)
    }
    return beforeCells
}
func neighbors(cell: (y: Int, x: Int) ) -> Array<(Int,Int)>{
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
        aboveCell.0 = 9
        diagonalUpLeft.0 = 9
        diagonalUpRIght.0 = 9
        rightCell.0 = 0
        leftCell.0 = 0
        belowCell.0 = 1
        diagonalDownLeft.0 = 1
        diagonalDownRight.0 = 1
    }else if cell.y == 9 {
        aboveCell.0 = 8
        diagonalUpLeft.0 = 8
        diagonalUpRIght.0 = 8
        rightCell.0 = 9
        leftCell.0 = 9
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
        diagonalUpLeft.1 = 9
        diagonalUpRIght.1 = 1
        rightCell.1 = 1
        leftCell.1 = 9
        belowCell.1 = 0
        diagonalDownLeft.1 = 9
        diagonalDownRight.1 = 1
    }else if cell.x == 9{
        aboveCell.1 = 9
        diagonalUpLeft.1 = 8
        diagonalUpRIght.1 = 0
        rightCell.1 = 0
        leftCell.1 = 8
        belowCell.1 = 9
        diagonalDownLeft.1 = 8
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

