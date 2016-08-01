
import UIKit

var globalPoints: [(Int, Int)]!
class SimulationViewController: UIViewController {
    
    @IBOutlet weak var gridView: GridView!
    
    var engine = StandardEngine.sharedEngine
    var timerOn = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: #selector(SimulationViewController.getTimer(_:)), name: "TimerOn", object: nil)
        nc.addObserver(self, selector: #selector(SimulationViewController.stopTimer(_:)), name: "TimerOff", object: nil)
    }
    override func viewDidAppear(animated: Bool) {
        gridView.rows = StandardEngine.sharedEngine.rows
        gridView.cols = StandardEngine.sharedEngine.cols
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(animated: Bool) {
        //let nc = NSNotificationCenter.defaultCenter()
        engine.refreshTimer?.invalidate()
    }
    func stopTimer(notification: NSNotification) {
        engine.refreshTimer!.invalidate()
    }
    func getTimer(notification: NSNotification) {
        print("here")
        engine.refreshTimer = NSTimer(timeInterval: engine.refreshRate, target: self, selector: #selector(SimulationViewController.stepGrid), userInfo: nil, repeats: true)
        engine.refreshTimer!.fire()
        
    }
    func stepGrid() {
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