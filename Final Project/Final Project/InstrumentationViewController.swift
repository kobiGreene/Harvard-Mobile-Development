
import UIKit

class InstrumentationViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var numberOfRows: UILabel!
    @IBOutlet weak var numberOfCols: UILabel!
    @IBOutlet weak var colsText: UITextField!
    @IBOutlet weak var rowsText: UITextField!
    @IBOutlet weak var linkText: UITextField!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var slider: UISlider!

    var userRefreshRate:Float = 0.0
    var switchOn = false
    var engine = StandardEngine.sharedEngine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        colsText.delegate = self
        rowsText.delegate = self
        mySwitch.addTarget(self, action: #selector(InstrumentationViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)

    }
   
    @IBAction func sliderValue(sender: AnyObject) {
        engine.refreshRate = Double(slider.value)
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            updateGrid()
            switchOn = true
        }else {
            switchOn = false
            stopTime()
        }
    }
    func updateGrid() {
        let userInfo = ["Timer": "On"]
        let notification = NSNotification(name: "TimerOn", object: self, userInfo: userInfo)
        NSNotificationCenter.defaultCenter().postNotification(notification)
        print("hello")
    }
    func stopTime() {
        let userInfo = ["Timer": "Off"]
        let notification = NSNotification(name: "TimerOff", object: self, userInfo: userInfo)
        NSNotificationCenter.defaultCenter().postNotification(notification)
        print("stop")
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
            if textField.text != nil && textField.text != " " && textField.text != ""{
                engine.rows = Int(numberOfRows.text!)!
            }
        }else if textField.tag == 2{
            numberOfCols.text = textField.text!
            if textField.text != nil && textField.text != " " && textField.text != ""{
                engine.cols = Int(numberOfCols.text!)!
            }
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func resetTableView(sender: AnyObject) {
        var info = ""
        if let linkText = linkText.text {
            info =  linkText
        }
        let userInfo = ["url": info]
        let notification = NSNotification(name: "reset", object: nil, userInfo: userInfo)
        NSNotificationCenter.defaultCenter().postNotification(notification)
    }
    

}

