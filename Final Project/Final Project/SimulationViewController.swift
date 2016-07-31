
import UIKit

class SimulationViewController: UIViewController {
    
    @IBOutlet weak var gridView: GridView!
    
    var engine = StandardEngine.sharedEngine
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveGrid(sender: AnyObject) {
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