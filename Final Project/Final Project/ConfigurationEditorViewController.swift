

import UIKit

class ConfigurationEditorViewController: UIViewController {
    @IBOutlet weak var gridView: GridView!
    
    var newPoints: [(Int,Int)]?
    override func viewDidLoad() {
        super.viewDidLoad()
        var highestPointRow = 0
        var highestPointCol = 0
        if newPoints != nil {
            if let points = newPoints {
                var highestPointsRow = points.map({$0.0}).sort({$0 > $1})
                var highestPointsCol = points.map({$0.1}).sort({$0 > $1})
                highestPointRow = highestPointsRow[0]
                highestPointCol = highestPointsCol[0]
                print(highestPointRow)
                print(highestPointCol)
                var minRows = highestPointRow + 1
                var minCols = highestPointCol + 1
                //Checking to see if previous row range is too small or too big
                if StandardEngine.sharedEngine.rows < minRows || StandardEngine.sharedEngine.rows > minRows + 1{
                    StandardEngine.sharedEngine.rows = minRows
                    gridView.rows = minRows
                }else {
                    gridView.rows = StandardEngine.sharedEngine.rows
                }
                if StandardEngine.sharedEngine.cols < minCols || StandardEngine.sharedEngine.cols > minCols + 1{
                    StandardEngine.sharedEngine.cols = minCols
                    gridView.cols = minCols
                }else {
                    gridView.cols = StandardEngine.sharedEngine.cols
                }
                GridView().points = points
            }
        }else {
                //StandardEngine.sharedEngine.rows = 20
                //StandardEngine.sharedEngine.cols = 20
                gridView.rows = StandardEngine.sharedEngine.rows
                gridView.cols = StandardEngine.sharedEngine.cols
        }
        
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveEdit(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
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
