
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
    
    var engine = StandardEngine.sharedEngine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        colsText.delegate = self
        rowsText.delegate = self
        mySwitch.addTarget(self, action: #selector(InstrumentationViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
       engine.refreshRate = Double(slider.value)

    }
   
    @IBAction func sliderValue(sender: AnyObject) {
        engine.refreshRate = Double(slider.value)
        print(engine.refreshRate)
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            engine.refreshTimer = NSTimer(timeInterval: engine.refreshRate, target: self, selector: #selector(InstrumentationViewController.updateGrid), userInfo: nil, repeats: true)
            engine.refreshTimer?.fire()
        }else {
           engine.refreshTimer?.invalidate()
        }
    }
    func updateGrid() {
        let userInfo = ["Timer": "Fired"]
        let notification = NSNotification(name: "Timer", object: self, userInfo: userInfo)
        NSNotificationCenter.defaultCenter().postNotification(notification)
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

