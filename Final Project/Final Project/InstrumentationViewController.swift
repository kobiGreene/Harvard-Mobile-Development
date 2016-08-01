
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
            if textField.text != nil || textField.text != " "{
                StandardEngine.sharedEngine.rows = Int(numberOfRows.text!)!
            }
        }else if textField.tag == 2{
            numberOfCols.text = textField.text!
            if textField.text != nil || textField.text != " "{
                StandardEngine.sharedEngine.cols = Int(numberOfCols.text!)!
            }
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func timerState(sender: AnyObject) {
    }
    @IBAction func resetTableView(sender: AnyObject) {
        var info = ""
        if let linkText = linkText.text {
            info =  linkText
        }
        var userInfo = ["url": info]
        let notification = NSNotification(name: "reset", object: nil, userInfo: userInfo)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    

}

