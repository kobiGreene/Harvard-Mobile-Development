//
//  EngineProtocol.swift
//  Assignment4
//
//  Created by Kobi Greene on 7/14/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//
import Foundation

protocol  EngineProtocol {
    var delegate: EngineDelegate? {get set}
    var grid: GridProtocol {get}
    var refreshRate: Double? {get set}
    var refreshTimer: NSTimer? {get set}
    var rows: Int {get set}
    var cols: Int {get set}
    
    init(rows: Int, cols: Int)
    
    func step() ->  GridProtocol
}