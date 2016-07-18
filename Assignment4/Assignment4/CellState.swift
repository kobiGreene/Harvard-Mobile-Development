//
//  CellState.swift
//  Assignment4
//
//  Created by Kobi Greene on 7/18/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

enum CellState: String {
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    
    //toggle functions
    static func toggle(value: CellState) -> CellState {
        switch value {
        case .Empty, .Died:
            return CellState.Living
        case .Living, .Born:
            return CellState.Empty
        }
    }
}