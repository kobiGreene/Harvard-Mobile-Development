//
//  StatisticsViewController.swift
//  Assignment4
//
//  Created by Kobi Greene on 7/13/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var aliveLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    @IBOutlet weak var emptyLabel: UILabel!
    var statGrid: GridProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let sel = #selector(StatisticsViewController.watchForNotifications(_:))
        let center  = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "gridNoti", object: nil)
    }
    func watchForNotifications(notification:NSNotification) {
        print(notification.userInfo!)
        //print("\(notification.userInfo)")
        //statGrid = notification.userInfo?.values as! GridProtocol
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

