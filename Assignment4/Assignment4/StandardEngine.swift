//
//  StandardEngine.swift
//  Assignment4
//
//  Created by Kobi Greene on 7/14/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import Foundation

var afterCells: GridProtocol!

class StandardEngine: EngineProtocol {
    var delegate: EngineDelegate?
    var grid: GridProtocol
    var refreshRate: Double?
    var refreshTimer: NSTimer?
    var rows: Int
    var cols: Int
    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        self.grid = Grid(rows: rows, cols: cols)

    }
    func step() ->  GridProtocol {
        afterCells = grid
        let maxCol = cols - 1
        let maxRows = rows - 1
        var surrondingCellAliveCounter = 0
        for y in 0...maxRows {
            for x in 0...maxCol {
                grid[y,x] = sGrid[y,x]
                surrondingCellAliveCounter = 0
                let neighborCells = Grid(rows: rows, cols: cols).neighbors((y, x))
                for cell in neighborCells {
                    if sGrid[cell.0,cell.1] == CellState.Living || grid[cell.0,cell.1] == CellState.Born {
                        surrondingCellAliveCounter += 1
                    }
                }
                //print("\(y) \(x)")
                //print(surrondingCellAliveCounter)
                // switching on the value of the current cell
                switch grid[y,x] {
                // Checking for the rules for the game of life
                case .Living:
                    if surrondingCellAliveCounter < 2 {
                        afterCells[y,x] = CellState.Died
                    }else if surrondingCellAliveCounter == 2 || surrondingCellAliveCounter == 3 {
                        afterCells[y,x] = CellState.Living
                    }else if surrondingCellAliveCounter > 3{
                        afterCells[y,x] = CellState.Died
                    }
                case .Born:
                    if surrondingCellAliveCounter < 2 {
                        afterCells[y,x] = CellState.Died
                    }else if surrondingCellAliveCounter == 2 || surrondingCellAliveCounter == 3 {
                        afterCells[y,x] = CellState.Living
                    }else if surrondingCellAliveCounter > 3{
                        afterCells[y,x] = CellState.Died
                    }
                case .Died:
                    if surrondingCellAliveCounter == 3 {
                        afterCells[y,x] = CellState.Born
                    }
                    else {
                        afterCells[y,x] = CellState.Empty
                    }
                case .Empty:
                    if surrondingCellAliveCounter == 3 {
                        afterCells[y,x] = CellState.Born
                    }
                    else {
                        afterCells[y,x] = CellState.Empty
                    }
                }
                
            }
            
        }
        return afterCells

        }
}
