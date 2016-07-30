//
//  ConfigurationEditorViewController.swift
//  ProjectPrototype
//
//  Created by Van Simmons on 7/23/16.
//  Copyright © 2016 S65g. All rights reserved.
//

import UIKit

class ConfigurationEditorViewController: UIViewController, EngineDelegate {
    @IBOutlet weak var gridView: GridView!
    
    var newPoints: [(Int,Int)]!
    override func viewDidLoad() {
        super.viewDidLoad()
        StandardEngine.sharedEngine.delegate = self
        print(newPoints)
        //GridView().points = newPoints
        //gridView.setNeedsDisplay()
        print(StandardEngine.sharedEngine.rows)
        // Do any additional setup after loading the view.
    }
    func engineDidUpdate(withGrid: GridProtocol) {
        print("called")
        gridView.setNeedsDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
