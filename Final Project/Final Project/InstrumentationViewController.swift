
import UIKit

class InstrumentationViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var numberOfRows: UILabel!
    @IBOutlet weak var numberOfCols: UILabel!
    @IBOutlet weak var colsText: UITextField!
    @IBOutlet weak var rowsText: UITextField!
    @IBOutlet weak var linkText: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        colsText.delegate = self
        rowsText.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.tag == 1 {
            numberOfRows.text = textField.text! + " " + "Rows"
        }else {
            numberOfCols.text = textField.text! + " " + "Cols"
        }
    }

    @IBAction func resetTableView(sender: AnyObject) {
        if let linkText = linkText.text {
            url = NSURL(string: linkText)
        }
        ConfigurationViewController().tableView.reloadData()
    }
    

}

