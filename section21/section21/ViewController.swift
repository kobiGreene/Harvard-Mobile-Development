//
//  ViewController.swift
//  section21
//
//  Created by Kobi Greene on 7/21/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var toPass : MyProtocol = MyClass()
        //let myWrapper = MyProtocolWrapper(variable: toPass)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(gotNot), name: "My Not", object: nil)
        NSNotificationCenter.defaultCenter().postNotificationName("My Not", object: nil, userInfo: ["Object": toPass])
        
       
        AppDelegate.myProtocolSingleton.myField = 1
    }
    func gotNot(not : NSNotification) {
        if let notif = not.userInfo!["Object"] {
            let myProto = notif as! MyProtocol
            print(myProto.myField)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

