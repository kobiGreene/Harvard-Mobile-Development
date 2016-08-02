
import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet weak var aliveLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    @IBOutlet weak var emptyLabel: UILabel!
    
    var engine = StandardEngine.sharedEngine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {
        aliveLabel.text = String(engine.grid.alive)
        bornLabel.text = String(engine.grid.born)
        diedLabel.text = String(engine.grid.died)
        emptyLabel.text = String(engine.grid.empty)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
