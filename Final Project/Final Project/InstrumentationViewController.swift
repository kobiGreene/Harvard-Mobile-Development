
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
        StandardEngine.sharedEngine.rows = Int(numberOfRows.text!)!
        StandardEngine.sharedEngine.cols = Int(numberOfCols.text!)!

    }
    @IBAction func addRow(sender: AnyObject) {
        let userInfo = ["Name": "New Configuration"]
        let notification = NSNotification(name: "NewRow", object: self, userInfo: userInfo)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.tag == 1 {
            numberOfRows.text = textField.text!
            if textField.text != nil {
                StandardEngine.sharedEngine.rows = Int(numberOfRows.text!)!
//                let userInfo = ["Row": textField.text!]
//                let notification = NSNotification(name: "NumRows", object: self, userInfo: userInfo)
//                NSNotificationCenter.defaultCenter().postNotification(notification)
            }
        }else if textField.tag == 2{
            numberOfCols.text = textField.text!
            if textField.text != nil {
                StandardEngine.sharedEngine.cols = Int(numberOfCols.text!)!
//                let userInfo = ["Col": textField.text!]
//                let notification = NSNotification(name: "NumCols", object: self, userInfo: userInfo)
//                NSNotificationCenter.defaultCenter().postNotification(notification)
            }
        }
    }

    @IBAction func resetTableView(sender: AnyObject) {
        if let linkText = linkText.text {
            url = NSURL(string: linkText)
        }
        ConfigurationViewController().tableView.reloadData()
    }
    

}

