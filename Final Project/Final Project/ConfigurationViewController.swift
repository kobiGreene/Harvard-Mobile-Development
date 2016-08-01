

import UIKit



class ConfigurationViewController: UITableViewController {
    
    var configurations: [GridConfiguration] = []
    var url: NSURL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        // Do any additional setup after loading the view.
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(ConfigurationViewController.updateTableView(_:)), name: "NewRow", object: nil)
        nc.addObserver(self, selector: #selector(ConfigurationViewController.userInput(_:)), name: "UserGrid", object: nil)
        nc.addObserver(self, selector: #selector(ConfigurationViewController.tableviewReload(_:)), name: "reset", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableviewReload(notification: NSNotification) {
        let info = NSURL(string: notification.userInfo!["url"] as! String)
        url = info
        configurations.removeAll()
        fetch()
    }
    func updateTableView(notification: NSNotification) {
        let title = notification.userInfo!["Name"] as! String
        configurations.append(GridConfiguration(title: title, points: nil))
        let itemRow = configurations.count - 1
        let itemPath = NSIndexPath(forRow:itemRow, inSection: 0)
        tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
    }
    func userInput (notification: NSNotification) {
        let config = notification.userInfo!["Config"]
        let title = config![0] as! String
        let userPoints = globalPoints
        configurations.append(GridConfiguration(title: title, points: userPoints))
        let itemRow = configurations.count - 1
        let itemPath = NSIndexPath(forRow:itemRow, inSection: 0)
        tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)

    }
    func fetch() {
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
        editingVC.savePoints = {
            self.configurations[editingRow] = $0
            let indexPath = NSIndexPath(forRow: editingRow, inSection: 0)
            self.tableView.reloadRowsAtIndexPaths([indexPath],
                                                  withRowAnimation: .Automatic)
        }

        
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      
        return "Configurations"
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    
    
}
