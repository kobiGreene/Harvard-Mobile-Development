

import UIKit

class ConfigurationEditorViewController: UIViewController {
    @IBOutlet weak var gridView: GridView!
    
    var newPoints: [(Int,Int)]?
    override func viewDidLoad() {
        super.viewDidLoad()
        var highestPointsRow = [Int]()
        var highestPointsCol = [Int]()
        if let points = newPoints {
            highestPointsRow = points.map({$0.0}).sort({$0 > $1})
            highestPointsCol = points.map({$0.1}).filter{$0 > 10}
        }
        print("Highest")
        print(highestPointsRow)
        print(highestPointsCol)
        gridView.rows = 55
        gridView.cols = 55
        StandardEngine.sharedEngine.rows = 55
        StandardEngine.sharedEngine.cols = 55
        //GridView().points = newPoints
        //gridView.setNeedsDisplay()
        print(StandardEngine.sharedEngine.rows)
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
