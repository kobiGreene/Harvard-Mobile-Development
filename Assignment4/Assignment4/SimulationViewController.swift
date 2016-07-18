//
//  SecondViewController.swift
//  Assignment4
//
//  Created by Kobi Greene on 7/13/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate {

    @IBOutlet weak var gridView: GridView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AppDelegate().engineSingleton?.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func engineDidUpdate(withGrid: GridProtocol) {
        //
    }
    @IBAction func iterateGrid(sender: AnyObject) {
        AppDelegate().engineSingleton!.step()
        gridView.setNeedsDisplay()
    }


}

