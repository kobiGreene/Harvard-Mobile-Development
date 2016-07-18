//
//  Grid.swift
//  Assignment4
//
//  Created by Kobi Greene on 7/14/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import Foundation

class Grid: GridProtocol {
    var rows: Int
    var cols: Int
    private var gridArr: Array<Array<CellState>>
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        gridArr = Array(count: rows, repeatedValue: Array(count: cols, repeatedValue: CellState.Empty))
    }
    func neighbors(gridPos: (Int,Int)) -> [(Int, Int)] {
        var maxCol = cols - 1
        var maxRows = rows - 1
        var rightCell = (0,0)
        var leftCell = (0,0)
        var belowCell = (0,0)
        var aboveCell = (0,0)
        var diagonalDownLeft = (0,0)
        var diagonalDownRight = (0,0)
        var diagonalUpLeft = (0,0)
        var diagonalUpRIght = (0,0)
        //Checking for the cells surronding the given current cell
        if gridPos.0 == 0 {
            aboveCell.0 = maxRows
            diagonalUpLeft.0 = maxRows
            diagonalUpRIght.0 = maxRows
            rightCell.0 = 0
            leftCell.0 = 0
            belowCell.0 = 1
            diagonalDownLeft.0 = 1
            diagonalDownRight.0 = 1
        }else if gridPos.0  == maxRows {
            aboveCell.0 = maxRows - 1
            diagonalUpLeft.0 = maxRows - 1
            diagonalUpRIght.0 = maxRows - 1
            rightCell.0 = maxRows
            leftCell.0 = maxRows
            belowCell.0 = 0
            diagonalDownLeft.0 = 0
            diagonalDownRight.0 = 0
            
        }else {
            aboveCell.0 = gridPos.0  - 1
            diagonalUpLeft.0 = gridPos.0  - 1
            diagonalUpRIght.0 = gridPos.0  - 1
            rightCell.0 = gridPos.0
            leftCell.0 = gridPos.0
            belowCell.0 = gridPos.0  + 1
            diagonalDownLeft.0 = gridPos.0  + 1
            diagonalDownRight.0 = gridPos.0  + 1
        }
        if gridPos.1 == 0 {
            aboveCell.1 = 0
            diagonalUpLeft.1 = maxCol
            diagonalUpRIght.1 = 1
            rightCell.1 = 1
            leftCell.1 = maxCol
            belowCell.1 = 0
            diagonalDownLeft.1 = maxCol
            diagonalDownRight.1 = 1
        }else if gridPos.1 == maxCol{
            aboveCell.1 = maxCol
            diagonalUpLeft.1 = maxCol - 1
            diagonalUpRIght.1 = 0
            rightCell.1 = 0
            leftCell.1 = maxCol - 1
            belowCell.1 = maxCol
            diagonalDownLeft.1 = maxCol - 1
            diagonalDownRight.1 = 0
        }else {
            aboveCell.1 = gridPos.1
            diagonalUpLeft.1 = gridPos.1 - 1
            diagonalUpRIght.1 = gridPos.1 + 1
            rightCell.1 = gridPos.1 + 1
            leftCell.1 = gridPos.1 - 1
            belowCell.1 = gridPos.1
            diagonalDownLeft.1 = gridPos.1 - 1
            diagonalDownRight.1 = gridPos.1 + 1
        }
        // creates an array of all cells surronding current cell
        let surrondingCells = [aboveCell, diagonalUpLeft, diagonalUpRIght, rightCell, leftCell, belowCell, diagonalDownLeft, diagonalDownRight]
        return surrondingCells

    }
    subscript(row: Int, col: Int) -> CellState {
        get {
            return gridArr[row][col]
        }
        set (newValue) {
            gridArr[row][col] = newValue
        }
    }
    
    
    
    
    
    
}