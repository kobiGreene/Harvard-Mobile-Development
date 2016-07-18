//
//  SecondViewController.swift
//  Assignment4
//
//  Created by Kobi Greene on 7/13/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    
    var engine = AppDelegate.sharedInstance
    
    @IBOutlet weak var gridView: GridView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        engine.delegate = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func engineDidUpdate(withGrid: GridProtocol) {
        //gridView.setNeedsDisplay()
    }
    @IBAction func iterateGrid(sender: AnyObject) {
        sGrid = engine.step()
        gridView.setNeedsDisplay()
    }


}

