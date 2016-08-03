

import UIKit

class ConfigurationEditorViewController: UIViewController {
    @IBOutlet weak var gridView: GridView!
    
    var newPoints: [(Int,Int)]?
    var engine = StandardEngine.sharedEngine
    var savePoints: (GridConfiguration -> Void)?
    var originalPoints: [(Int,Int)]?
    override func viewDidLoad() {
        super.viewDidLoad()
        if newPoints != nil {
            if let points = newPoints {
                let highestPointRow = points.map({$0.0}).reduce(0) {$0 > $1 ? $0 : $1}
                let highestPointCol = points.map({$0.1}).reduce(0) {$0 > $1 ? $0 : $1}
                print(highestPointRow)
                print(highestPointCol)
                let minRows = highestPointRow + 5
                let minCols = highestPointCol + 5
                //Checking to see if previous row range is too small or too big
                if engine.rows < minRows || engine.rows > minRows + 20 {
                    print("changing")
                    engine.rows = minRows
                    gridView.rows = minRows
                }else {
                    print("same")
                    engine.rows = engine.rows
                    gridView.rows = engine.rows
                }
                if engine.cols < minCols || engine.cols > minCols + 20 {
                    print("changing")
                    engine.cols = minCols
                    gridView.cols = minCols
                }else {
                    print("same")
                    engine.cols = engine.cols
                    gridView.cols = engine.cols
                }
                originalPoints = points
                gridView.points = points
            }
        }else {
            engine.rows = engine.rows
            engine.cols = engine.cols
            gridView.rows = engine.rows
            gridView.cols = engine.cols
        }
        
        

    }
    func isLiving(y: Int, x: Int) -> Bool {
        return StandardEngine.sharedEngine.grid[y,x].isLiving()
    }
    func switchToAlive(y: Int, x: Int) {
        StandardEngine.sharedEngine.grid[y,x] = CellState.Alive
    }
    func switchToEmpty(y: Int, x: Int) {
        StandardEngine.sharedEngine.grid[y,x] = CellState.Empty
    }
    func gridStates(y: Int, x: Int) -> CellState {
            return engine.grid[y,x]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func useConfig(sender: AnyObject) {
         self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func saveEdit(sender: AnyObject) {
        let alertView = UIAlertController(title: "Save This Configuration", message: "Enter A Name", preferredStyle: .Alert)
        
        alertView.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Input Name"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (alert) -> Void in
            let textField = alertView.textFields![0]
            globalPoints = self.gridView.points
            let text = textField.text!
            self.savePoints!(GridConfiguration(title: text, points: self.gridView.points))
            self.navigationController?.popViewControllerAnimated(true)
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (alert) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        alertView.addAction(cancelAction)
        alertView.addAction(saveAction)
        presentViewController(alertView, animated: true, completion:nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
