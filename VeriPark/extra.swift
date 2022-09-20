//
//  extra.swift
//  VeriPark
//
//  Created by sameeltariq on 20/09/2022.
//

import Foundation

//            let getFromDate = dateToShow.last
//            let differenceBaseOnDate = (Int(self.currentMeterReadingTF.text ?? "0") ?? 0) - (getFromDate?.currentMeterReading ?? 0)
//            print(differenceBaseOnDate)
//            self.createObjectAndSave(difference: differenceBaseOnDate)
//            let dateStringToFind = "2022-09-20"
//            let dateFormate = DateFormatter()
//            dateFormate.dateFormat =  "yyyy-MM-dd"
//            let dateObjectToFind = dateFormate.date(from: dateStringToFind)
//            let dateToShow = realm.objects(CustomDataClass.self).filter("date == %@", dateObjectToFind ?? "")
//            print(dateToShow)
//            if dateToShow.count > 0 {
//                for myObject in dateToShow {
//                    print(myObject)
//                }
//            } else {
//                print("no objects have that date")
//            }




        

/*

if realm.isEmpty{
if let firstentry = serviceNoTF.text{
   
}
if let firstCurrentEntry = currentMeterReadingTF.text {
    
}

}
else
{

if let serviceNo = serviceNoTF.text{
    object.serviceNumber = serviceNo
    getRealmArray =  Array(realm.objects(CustomDataClass.self))
    let  resultPredicate = NSPredicate(format: "self contains[cd] %@", serviceNo)
    let filteredArray = getRealmArray.filter {
        resultPredicate.evaluate(with: $0.serviceNumber)
    }
    
    print(filteredArray)
    if serviceNo == object.serviceNumber{
        print(serviceNo)
        if let currentEntry = currentMeterReadingTF.text{
            let currentEnteredValue  = Int(currentEntry) ?? 0
            object.currentMeterReading = currentEnteredValue
            // FETCH DATA
            let fetchData = realm.objects(CustomDataClass.self)
            let size = fetchData.count
            let getCurrentValue = fetchData[size - 1]
            
            let secondLast =   getCurrentValue.currentMeterReading
            let totalconsumptionUnits = currentEnteredValue - secondLast
            print(totalconsumptionUnits)
            
            if currentEnteredValue < secondLast{
                alertForObject()
            }
            else{
                object.totalConsumption = totalconsumptionUnits
                let totalBillCons = totalconsumptionUnits
                object.totalBill = calculateTotalBill(units: totalBillCons)
                do {
                    try realm.write({
                        realm.add(object) // add object
                    })
                }
                catch{
                    print(error)
                }
            }
        }
    }
}
}
*/
