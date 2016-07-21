//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var rows = 10
var cols = 10

typealias Position = (row: Int, col: Int)

let offsets: [Position] = [
    (-1,1), (-1,0), (-1,1),
    ( 0,-1),        ( 0,1),
    ( 1,-1), ( 1,0), ( 1,1)
]

func neighbors(pos: Position) -> [Position] {
    return offsets.map { ((pos.row + rows + $0.row) % rows, (pos.col + cols + $0.col) %  cols)}
}

typealias CellState = Bool
typealias Cell = (position:Position, alive:CellState)

var toyGrid = [Cell](count: rows*cols, repeatedValue: ((0,0), false))
for var i in 0..<rows {
    for var j in 0..<cols {
        toyGrid[i*cols+j] = ((i,j), arc4random_uniform(3) == 1)
    }
}

let numCells = rows*cols
for var i in 0..<numCells {
    toyGrid[i] = ((i/cols, i%cols), arc4random_uniform(3) == 1)
}

var grid = (0..<numCells).map {
    (($0/cols, $0%cols), arc4random_uniform(3) == 1) as Cell
}

func countLiving(grid: [Cell]) -> Int {
    return grid.reduce(0) { return $1.alive ? $0 + 1: $0 }
}

func countLivingNeighbors(grid: [Cell], cell: Cell) -> Int {
    return neighbors((cell.position.row, cell.position.col)).reduce(0) {grid[$1.row*cols + $1.col].alive ? $0 + 1 : $0 }
}

func step(grid:[Cell]) -> [Cell] {
    return grid.map {
        switch countLivingNeighbors(grid, cell: $0) {
        case 3,2 where $0.alive: return ($0.position, true)
        default: return ($0.position, false)
        }
    }
}

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)

grid = step(grid)
countLiving(grid)














