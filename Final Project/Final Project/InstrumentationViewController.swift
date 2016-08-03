
import UIKit

class InstrumentationViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var numberOfRows: UILabel!
    @IBOutlet weak var numberOfCols: UILabel!
    @IBOutlet weak var colsText: UITextField!
    @IBOutlet weak var rowsText: UITextField!
    @IBOutlet weak var linkText: UITextField!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var slider: UISlider!

    var switchOn = false
    var engine = StandardEngine.sharedEngine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        engine.refreshRate = Double(slider.value)
        // Do any additional setup after loading the view, typically from a nib.
        colsText.delegate = self
        rowsText.delegate = self
        mySwitch.addTarget(self, action: #selector(InstrumentationViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)

    }
   
    @IBAction func sliderValue(sender: AnyObject) {
        engine.refreshRate = Double(slider.value)
        if switchOn {
            engine.refreshTimer?.invalidate()
            engine.refreshTimer = NSTimer.scheduledTimerWithTimeInterval(engine.refreshRate, target: self, selector: #selector(InstrumentationViewController.fireTimerNotif), userInfo: nil, repeats: true)
        }
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            engine.refreshTimer = NSTimer.scheduledTimerWithTimeInterval(engine.refreshRate, target: self, selector: #selector(InstrumentationViewController.fireTimerNotif), userInfo: nil, repeats: true)
            switchOn = true
        }else {
            if engine.refreshTimer != nil {
                engine.refreshTimer!.invalidate()
            }
            switchOn = false
            
        }
    }
    func fireTimerNotif() {
        let userInfo = ["Timer": "Timer Fired"]
        let notification = NSNotification(name: "TimerOn", object: self, userInfo: userInfo)
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
        mySwitch.setOn(false, animated: true)
        if textField.tag == 1 {
            numberOfRows.text = textField.text!
            if textField.text != nil && textField.text != " " && textField.text != "" && !(textField.text?.containsString(" "))!{
                var userRows = Int(numberOfRows.text!)!
                engine.rows = userRows
                }
        }else if textField.tag == 2{
            numberOfCols.text = textField.text!
            if textField.text != nil && textField.text != " " && textField.text != "" && !(textField.text?.containsString(" "))!{
                var userCols = Int(numberOfCols.text!)!
                    engine.cols = userCols
               
            }
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
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

