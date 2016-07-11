//
//  ViewController.swift
//  Assignment3
//
//  Created by Kobi Greene on 7/7/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import UIKit

enum CellState: String {
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    
    func description() -> String{
        switch self {
        case .Living:
            return CellState.Living.rawValue
        case .Empty:
            return CellState.Empty.rawValue
        case .Born:
            return CellState.Born.rawValue
        case .Died:
            return CellState.Died.rawValue
        }
    }
    func allValues() -> Array<CellState.RawValue> {
        let arrayCS: Array<CellState.RawValue> = [CellState.Living.rawValue, CellState.Empty.rawValue, CellState.Born.rawValue, CellState.Died.rawValue]
        return arrayCS
    }
    static func toggle(value: CellState) -> CellState {
        switch value {
        case .Empty, .Died:
            return CellState.Living
        case .Living, .Born:
            return CellState.Empty
        }
    }
}
var afterCells = [[CellState]]()
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var one = CellState.Living.description()
        var two = CellState.Empty.allValues()
        var three = CellState.toggle(CellState.Born)
        print(one)
        print(two)
        print(three)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func iterate(sender: AnyObject) {
        
        afterCells = GridView().step2(grid)
        grid = afterCells
        //print(afterCells)
        print(grid)
        GridView().setNeedsDisplayInRect(self.view.frame)
    }

}

























