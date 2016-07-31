

import UIKit

class ConfigurationEditorViewController: UIViewController {
    @IBOutlet weak var gridView: GridView!
    
    var newPoints: [(Int,Int)]?
    override func viewDidLoad() {
        super.viewDidLoad()
        var highestPointRow = 0
        var highestPointCol = 0
        if let points = newPoints {
            var highestPointsRow = points.map({$0.0}).sort({$0 > $1})
            var highestPointsCol = points.map({$0.1}).sort({$0 > $1})
            highestPointRow = highestPointsRow[0]
            highestPointCol = highestPointsCol[0]
            
        }
        print(highestPointRow)
        print(highestPointCol)
        StandardEngine.sharedEngine.rows = highestPointRow
        StandardEngine.sharedEngine.cols = highestPointCol
        gridView.rows = highestPointRow
        gridView.cols = highestPointCol
        //GridView().points = newPoints
        //gridView.setNeedsDisplay()
        // Do any additional setup after loading the view.
        for y in 0..<StandardEngine.sharedEngine.rows {
            for x in 0..<StandardEngine.sharedEngine.cols {
                for point in newPoints! {
                    if y == point.0 && x == point.1{
                        StandardEngine.sharedEngine.grid[point.0, point.1] = CellState.Alive
                        print("here")
                    }else {
                        StandardEngine.sharedEngine.grid[y,x] = CellState.Empty
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
