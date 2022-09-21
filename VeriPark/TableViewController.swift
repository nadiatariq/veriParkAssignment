//
//  TableViewController.swift
//  VeriPark
//
//  Created by sameeltariq on 09/09/2022.
//

import UIKit
import RealmSwift
class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let realm = try!Realm()
    var getData = [CustomDataClass]()

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var saveButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchData()
        tableView.reloadData()
        saveButton.layer.cornerRadius = 18
        
        
                self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func calculateTotalBill(units: Int){
        if (units <= 100){
            let firstSlab = units * 5
            print(firstSlab)
            print(" first slab : \(firstSlab)")
        }
        else if (units <= 500)
        {
            let secondSlab = (100 * 5) + (units - 100) * 8
            print(" Second slab : \(secondSlab)")
        }
        else if (units > 500)
        {
            let thirdSlab = (100 * 5) + (400  * 8) + (units - 500) * 10
            print(" Third slab : \(thirdSlab)")
        }
    }
    func fetchData() {
      
        getData = Array(realm.objects(CustomDataClass.self)).suffix(3)
//        for item in realm.objects(CustomDataClass.self).filter({Bool($0.serviceNumber ?? "") ?? true }).suffix(3) {
//           print(item)
//        }

   }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        var fetchAndShow = CustomDataClass()
        fetchAndShow = getData[indexPath.row]
//        print(fetchAndShow)
            cell.previous.text = " \(fetchAndShow.currentMeterReading)"
        cell.serviceNo.text = fetchAndShow.serviceNumber
            print("This is consumption result")
            let getCurrent = fetchAndShow.totalConsumption
            calculateTotalBill(units: getCurrent)
            cell.totalBillOfConsumption.text = " \(fetchAndShow.totalBill)"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0     //Choose your custom row height
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        let realm = try! Realm()
        if editingStyle == .delete {
            
                let recordForDeletion = getData[indexPath.row]
                do {
                    try realm.write {
                        realm.delete(recordForDeletion)
                    }
                } catch {
                    print("Error deleting course: \(error)")
                }
                // Delete the row from the data source
                getData.remove(at: indexPath.row)
            }
            
            // Then, delete the row from the table itself
            tableView.deleteRows(at: [indexPath], with: .fade)
        }

}

