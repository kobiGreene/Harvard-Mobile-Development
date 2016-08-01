

import UIKit

class ConfigurationEditorViewController: UIViewController {
    @IBOutlet weak var gridView: GridView!
    
    var newPoints: [(Int,Int)]?
    var engine = StandardEngine.sharedEngine
    var savePoints: (GridConfiguration -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        if newPoints != nil {
            if let points = newPoints {
                let highestPointRow = points.map({$0.0}).reduce(0) {$0 > $1 ? $0 : $1}
                let highestPointCol = points.map({$0.1}).reduce(0) {$0 > $1 ? $0 : $1}
                print(highestPointRow)
                print(highestPointCol)
                let minRows = highestPointRow + 1
                let minCols = highestPointCol + 1
                //Checking to see if previous row range is too small or too big
                if engine.rows < minRows || engine.rows > minRows + 10 {
                    engine.rows = minRows
                    gridView.rows = minRows
                }else {
                    engine.rows = engine.rows
                    gridView.rows = engine.rows
                }
                if engine.cols < minCols || engine.cols > minCols + 10{
                    engine.cols = minCols
                    gridView.cols = minCols
                }else {
                    engine.cols = engine.cols
                    gridView.cols = engine.cols
                }
                GridView().points = points
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveEdit(sender: AnyObject) {
        savePoints!(GridConfiguration(title: "New Config", points: gridView.points))
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
