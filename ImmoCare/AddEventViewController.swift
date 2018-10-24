import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var myDateLabel: UILabel!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    
    let startPicker = UIDatePicker()
    let endPicker = UIDatePicker()
    
    var data: DataList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDateTextField.addTarget(self, action: #selector(createStartDatePicker), for: .touchDown)
        endDateTextField.addTarget(self, action: #selector(createEndDatePicker), for: .touchDown)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // get event's data
    func getData(data: DataList) {
        self.data = data
    } // function getData
    
    // create picker to pick start date
    @objc func createStartDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(startDateConverter))
        toolbar.setItems([done], animated: false)
        
        startDateTextField.inputAccessoryView = toolbar
        startDateTextField.inputView = startPicker
        
        startPicker.datePickerMode = .date
        
    } // function createStartDatePicker
    
    // create picker to pick end date
    @objc func createEndDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(endDateConverter))
        toolbar.setItems([done], animated: false)
        
        endDateTextField.inputAccessoryView = toolbar
        endDateTextField.inputView = endPicker
        
        endPicker.datePickerMode = .date
        
    } // function createEndDatePicker
    
    // convert start date to string
    @objc func startDateConverter() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: startPicker.date)
        
        startDateTextField.text = "\(dateString)"
        self.view.endEditing(true)
        
    } // func startDateConverter
    
    // convert end date to string
    @objc func endDateConverter() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: endPicker.date)
        
        endDateTextField.text = "\(dateString)"
        self.view.endEditing(true)
        
    } // func endDateConverter
    
    // button save event
    @IBAction func saveAction(_ sender: Any) {
        if titleTextField.text != "" && descriptionTextView.text != ""
            && startDateTextField.text != "" && endDateTextField.text != "" {
            
            // save data in cell collection
            data?.eventsList[0].events.append(Event(titled: titleTextField.text!, desc: descriptionTextView.text!, startDated: startDateTextField.text!, endDated: endDateTextField.text!))
            
            // save event in ios calendar app
            EventHandler.instance.addEvent(title: titleTextField.text!, msg: descriptionTextView.text!, start: startDateTextField.text!, end: endDateTextField.text!);
            
            let alert = UIAlertController(title: titleTextField.text!, message: "Event successfully added", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            
            // reset value 
            titleTextField.text = ""
            descriptionTextView.text = ""
            startDateTextField.text = ""
            endDateTextField.text = ""
        }
        else {
            let alert = UIAlertController(title: "Warning", message: "write something", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
        }
    } // function saveAction
}
