//
//  StandardEngine.swift
//  Assignment4
//
//  Created by Kobi Greene on 7/14/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import Foundation

class StandardEngine: EngineProtocol {
    var delegate: EngineDelegate?
    var grid: GridProtocol
    var refreshRate: Double?
    var refreshTimer: NSTimer?
    var rows: Int
    var cols: Int
    
    private static var _sharedInstance = StandardEngine(rows: 10, cols: 10)
    static var sharedInstance: StandardEngine {
        get {
            return _sharedInstance
        }
    }
    

    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        self.grid = Grid(rows: rows, cols: cols)

    }
    func step() ->  GridProtocol {
        let maxCol = cols - 1
        let maxRows = rows - 1
        var surrondingCellAliveCounter = 0
        let gridInstance = AppDelegate().engineSingleton?.grid
        for y in 0...maxRows {
            for x in 0...maxCol {
                surrondingCellAliveCounter = 0
                let neighborCells = Grid(rows: rows, cols: cols).neighbors((y, x))
                for cell in neighborCells {
                    if gridInstance![cell.0, cell.1] == CellState.Living || gridInstance![cell.0, cell.1] == CellState.Born {
                        surrondingCellAliveCounter += 1
                    }
                }
                //print("\(y) \(x)")
                //print(surrondingCellAliveCounter)
                // switching on the value of the current cell
                switch gridInstance![y,x] {
                // Checking for the rules for the game of life
                case .Living:
                    if surrondingCellAliveCounter < 2 {
                        afterCells[y][x] = CellState.Died
                    }else if surrondingCellAliveCounter == 2 || surrondingCellAliveCounter == 3 {
                        afterCells[y][x] = CellState.Living
                    }else if surrondingCellAliveCounter > 3{
                        afterCells[y][x] = CellState.Died
                    }
                case .Born:
                    if surrondingCellAliveCounter < 2 {
                        afterCells[y][x] = CellState.Died
                    }else if surrondingCellAliveCounter == 2 || surrondingCellAliveCounter == 3 {
                        afterCells[y][x] = CellState.Living
                    }else if surrondingCellAliveCounter > 3{
                        afterCells[y][x] = CellState.Died
                    }
                case .Died:
                    if surrondingCellAliveCounter == 3 {
                        afterCells[y][x] = CellState.Born
                    }
                    else {
                        afterCells[y][x] = CellState.Empty
                    }
                case .Empty:
                    if surrondingCellAliveCounter == 3 {
                        afterCells[y][x] = CellState.Born
                    }
                    else {
                        afterCells[y][x] = CellState.Empty
                    }
                }
                grid[y,x] = afterCells[y][x]
            }
            
        }
        return grid

        }
}
