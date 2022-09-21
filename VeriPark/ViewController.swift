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
      
        self.serviceNoTF.valueType = .alphaNumeric
        self.currentMeterReadingTF.valueType = .onlyNumbers
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
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
//        let filtered = Array(realm.objects(CustomDataClass.self).filter({($0.serviceNumber ?? "").lowercased() == (self.serviceNoTF.text ?? "").lowercased() }))
       // ============================//
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay) ?? Date()
        let predicate = NSPredicate(format: "date >= %@ && date < %@", startOfDay as NSDate, endOfDay as NSDate)
        let todaysBill =  Array(realm.objects(CustomDataClass.self).filter(predicate).filter({ ($0.serviceNumber ?? "").lowercased() == (self.serviceNoTF.text ?? "").lowercased()}))
        
        // ============================//
        if todaysBill.isEmpty {
            // Insert new object
            print("New service number")
            self.createObjectAndSave(difference:  Int(self.currentMeterReadingTF.text ?? "0") ?? 0)
        }
        
        
        else{
            if let currentMeterReading = currentMeterReadingTF.text{
                object.currentMeterReading = Int(currentMeterReading) ?? 0
                if Int(currentMeterReading) ?? 0  < todaysBill.last?.currentMeterReading ?? 0{
                    alertForObject()
                }
                else{
                    //get last object and calculate bill
                    print("Service number already exist")
//                    let lastObject = filtered.last
//                    let difference = (Int(self.currentMeterReadingTF.text ?? "0") ?? 0) - (lastObject?.currentMeterReading ?? 0)
//                    self.createObjectAndSave(difference: difference)
                    let lastDifferenceObject = todaysBill.last
                    let getLastDifference = (Int(self.currentMeterReadingTF.text ?? "0") ?? 0) - (lastDifferenceObject?.currentMeterReading ?? 0)
                    self.createObjectAndSave(difference: getLastDifference)
//
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
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        if segue.identifier == "next" {
            if let nextVC = segue.destination as? TableViewController{
            
            }
        }
    }
}
