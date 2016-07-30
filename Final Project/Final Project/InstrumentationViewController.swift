
import UIKit

class InstrumentationViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var numberOfRows: UILabel!
    @IBOutlet weak var numberOfCols: UILabel!
    @IBOutlet weak var colsText: UITextField!
    @IBOutlet weak var rowsText: UITextField!

    
    
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
        print("hello")
        if textField.tag == 1 {
            print("here1")
            numberOfRows.text = textField.text! + " " + "Rows"
        }else {
            print("here2")
            numberOfCols.text = textField.text! + " " + "Cols"
        }
    }

}

