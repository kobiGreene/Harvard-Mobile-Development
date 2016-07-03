//
//  ViewController.swift
//  Lecture3B
//
//  Created by Kobi Greene on 6/27/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBAction func buttonClicked(sender: AnyObject) {
        textView.text = "We Were Clicked"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

