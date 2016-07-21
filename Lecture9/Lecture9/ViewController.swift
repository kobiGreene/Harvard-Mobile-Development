//
//  ViewController.swift
//  Lecture9
//
//  Created by Kobi Greene on 7/20/16.
//  Copyright © 2016 Kobi Greene. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private var names = ["Van", "Nate", "JP"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addName(sender: AnyObject) {
        names.append("Add new name")
        let itemRow = names.count - 1
        let itemPath = NSIndexPath(forRow: itemRow, inSection: 0)
        tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
    }
    
    
    //MARK: UITableViewDelegation
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
            else {
                preconditionFailure("Missing cell reuse identifier")
        }
        let row = indexPath.row
        guard let nameLabel = cell.textLabel else {
            preconditionFailure("hello??")
        }
        nameLabel.text = names[row]
        cell.tag = row
        return cell
    }
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            names.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let edititingRow = (sender as! UITableViewCell).tag
        let editingString = names[edititingRow]
        guard let edititingVC = segue.destinationViewController as? EditViewController
            else {
                preconditionFailure("Another wtf?")
        }
        edititingVC.name = editingString
        edititingVC.commit = {
            self.names[edititingRow] = $0
            let indexPath = NSIndexPath(forRow: edititingRow, inSection: 0)
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
        }
    }

}

















