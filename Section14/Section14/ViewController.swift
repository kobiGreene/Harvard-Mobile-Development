//
//  ViewController.swift
//  Section14
//
//  Created by Kobi Greene on 7/14/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Useless"
        let result = divide(8, dividend: 3)
        let i = 0
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func divide(divisor: Int, dividend: Int) -> (Int, Int) {
        var remainder = divisor
        var result = 0
        
        while remainder > 0 {
            remainder -= dividend
            result += 1
        }
        return (result, remainder)
    }


}

