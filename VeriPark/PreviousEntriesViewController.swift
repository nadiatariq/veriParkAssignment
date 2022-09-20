//
//  PreviousEntriesViewController.swift
//  VeriPark
//
//  Created by sameeltariq on 16/09/2022.
//

import UIKit
import RealmSwift
class PreviousEntriesViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    var getPreviousValues = [CustomDataClass]()
    let realm = try!Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
fetchData()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    func fetchData() {
        getPreviousValues = Array(realm.objects(CustomDataClass.self)).suffix(3)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getPreviousValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PreviousTableViewCell
        var fetchAndShow = CustomDataClass()
        fetchAndShow = getPreviousValues[indexPath.row]
        cell.previousValue.text = "  Previous value is   \(fetchAndShow.currentMeterReading)"
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
