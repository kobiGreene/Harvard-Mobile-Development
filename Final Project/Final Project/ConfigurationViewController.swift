

import UIKit

var url: NSURL?
class ConfigurationViewController: UITableViewController {
    var configurations: [GridConfiguration] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetch() {
        print("fetch called")
        print(url)
        if url == nil {
            url = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")!
        }
        let fetcher = Fetcher()
        fetcher.requestJSON(url!) { (json, message) in
            if let json = json {
                let correctType = json as! [AnyObject]
                let parser = GridConfigurationParser(configurations: correctType)
                self.configurations = parser.parse()!
            }
            let op = NSBlockOperation {
                self.tableView.reloadData()
            }
            NSOperationQueue.mainQueue().addOperation(op)
        }
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurations.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        cell?.textLabel?.text = configurations[indexPath.row].title
        cell?.tag = indexPath.row
        return cell!
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let editingRow = (sender as! UITableViewCell).tag
        let editingString = configurations[editingRow].title
        let editingPoints = configurations[editingRow].points
        guard let editingVC = segue.destinationViewController as? ConfigurationEditorViewController
            else {
                preconditionFailure("Bad")
        }
      
        editingVC.title = editingString
        editingVC.newPoints = editingPoints
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    
}
