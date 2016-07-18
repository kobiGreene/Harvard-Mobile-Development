//
//  GridProtocol.swift
//  Assignment4
//
//  Created by Kobi Greene on 7/14/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

protocol GridProtocol {
    init(rows: Int, cols: Int)
    var rows: Int {get}
    var cols: Int {get}
    func neighbors(gridPos: (Int,Int)) -> [(Int, Int)]
    subscript(row: Int, col: Int) -> CellState {get set}
}