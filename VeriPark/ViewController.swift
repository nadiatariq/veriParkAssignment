//
//  ViewController.swift
//  VeriPark
//
//  Created by sameeltariq on 09/09/2022.
//

import UIKit
import RealmSwift
class ViewController: UIViewController , UITextFieldDelegate{
    let realm = try! Realm()
    var getCustomData : CustomDataClass?
    var getRealmArray = [CustomDataClass]()
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var serviceNoTF: ValidationsTextField!
    @IBOutlet weak var currentMeterReadingTF: ValidationsTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //        fetchData()
        submitButton.layer.cornerRadius = 20
        nextButton.layer.cornerRadius = 20
        
        
        self.serviceNoTF.maxLength  =  8
        self.serviceNoTF.valueType = .alphaNumeric
        self.currentMeterReadingTF.valueType = .onlyNumbers
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
//    func getDateOnly(fromTimeStamp timestamp: TimeInterval) -> String {
//        let dateFormate = DateFormatter()
//        dateFormate.timeZone = TimeZone.current
//        dateFormate.dateFormat =  "MMMM dd, yyyy - h:mm:ss a z"
//        return dateFormate.string(from: Date(timeIntervalSince1970: timestamp))
//    }
    
    @IBAction func nextActionButton(_ sender: Any) {
        self.serviceNoTF.text = nil
        self.currentMeterReadingTF.text = nil
    }
    
    func createObjectAndSave(difference: Int) {
        let object = CustomDataClass()
        object.serviceNumber                = self.serviceNoTF.text ?? ""
        object.currentMeterReading  = Int(self.currentMeterReadingTF.text ?? "0") ?? 0
        object.totalConsumption         = difference//Int(self.currentMeterReadingTF.text ?? "0") ?? 0
        object.totalBill = calculateTotalBill(units: difference)
        object.date = Date()
        
        do {
            try realm.write({
                realm.add(object) // add object
            })
        }
        catch{
            print(error)
        }
    }
    
    @IBAction func submitActionButton(_ sender: Any) {
        if serviceNoTF.text!.isEmpty || currentMeterReadingTF.text!.isEmpty{
            alert()
        }
        let object = CustomDataClass()
        
        print()
        let filtered = Array(realm.objects(CustomDataClass.self).filter({($0.serviceNumber ?? "").lowercased() == (self.serviceNoTF.text ?? "").lowercased() }))
        if filtered.isEmpty {
            // Insert new object
            print("New service number")
            self.createObjectAndSave(difference:  Int(self.currentMeterReadingTF.text ?? "0") ?? 0)
        }
        
        
        else{
            if let currentMeterReading = currentMeterReadingTF.text{
                object.currentMeterReading = Int(currentMeterReading) ?? 0
                print(currentMeterReading)
                if Int(currentMeterReading) ?? 0  < filtered.last?.currentMeterReading ?? 0{
                    alertForObject()
                }
                else{
                    //get last object and calculate bill
                    print("Service number already exist")
                    let lastObject = filtered.last
                    let difference = (Int(self.currentMeterReadingTF.text ?? "0") ?? 0) - (lastObject?.currentMeterReading ?? 0)
                    self.createObjectAndSave(difference: difference)
                }
            }
        }
        
    }
    func calculateTotalBill(units: Int) -> Int{
        if (units <= 100){
            let firstSlab = units * 5
            print(" first slab : \(firstSlab)")
            return firstSlab
        }
        else if (units <= 500)
        {
            let secondSlab = (100 * 5) + (units - 100) * 8
            print(" Second slab : \(secondSlab)")
            return secondSlab
        }
        else if (units > 500)
        {
            let thirdSlab = (100 * 5) + (400  * 8) + (units - 500) * 10
            
            print(" Third slab : \(thirdSlab)")
            return thirdSlab
        }
        return units
    }
    func alert(){
        let alert = UIAlertController(title: "Alert", message: "Please Valid Entries In Fields", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    func alertForObject(){
        let alert = UIAlertController(title: "Alert", message: "Please Enter Grater Then Previous", preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Verify all the conditions
        if let sdcTextField = textField as? ValidationsTextField {
            return sdcTextField.verifyFields(shouldChangeCharactersIn: range, replacementString: string)
        }
        return true
    }
}
