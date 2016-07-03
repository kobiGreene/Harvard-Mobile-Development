//
//  Problem4ViewController.swift
//  Assignment2
//
//  Created by Kobi Greene on 7/3/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import UIKit

class Problem4ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Problem 4"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: AnyObject) {
        textView.text = "Button Was Pressed!"
    }
    
    
}
