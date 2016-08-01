
import UIKit

var globalPoints: [(Int, Int)]!
class SimulationViewController: UIViewController {
    
    @IBOutlet weak var gridView: GridView!
    
    var engine = StandardEngine.sharedEngine
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        gridView.rows = StandardEngine.sharedEngine.rows
        gridView.cols = StandardEngine.sharedEngine.cols
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(SimulationViewController.stepGrid(_:)), name: "Timer", object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(animated: Bool) {
        let nc = NSNotificationCenter.defaultCenter()
        nc.removeObserver(self, name: "Timer", object: nil)
    }
    func stepGrid(notification: NSNotification) {
        print("recieved")
        engine.step()
        gridView.setNeedsDisplay()
    }

    @IBAction func saveGrid(sender: AnyObject) {
        let alertView = UIAlertController(title: "Save This Configuration", message: "Enter A Name", preferredStyle: .Alert)
        
        alertView.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Input Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (alert) -> Void in
            let textField = alertView.textFields![0]
            globalPoints = self.gridView.points
            let text = textField.text!
            let info = [text]
            let userInfo = ["Config": info]
            let notification = NSNotification(name: "UserGrid", object: self, userInfo: userInfo)
            NSNotificationCenter.defaultCenter().postNotification(notification)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (alert) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertView.addAction(cancelAction)
        alertView.addAction(saveAction)
        presentViewController(alertView, animated: true, completion:nil)
    }
    
    @IBAction func resetGrid(sender: AnyObject) {
        for y in 0..<engine.grid.rows {
            for x in 0..<engine.grid.cols {
                engine.grid[y,x] = CellState.Empty
            }
        }
        gridView.setNeedsDisplay()
    }

}