//
//  ServiceNumbers.swift
//  VeriPark
//
//  Created by sameeltariq on 09/09/2022.
//

import Foundation
import RealmSwift
class  CustomDataClass : Object{
        @objc  dynamic var totalConsumption                  = 0
        @objc  dynamic var totalBill                                    = 0
        @objc  dynamic var currentMeterReading           =  0
        @objc dynamic var serviceNumber : String?
        @objc dynamic var date : Date!
//    convenience init(_ content: String) {
//            self.init()
//        let formatter = DateFormatter()
//                formatter.timeStyle = .none
//                formatter.dateFormat = "MM/dd/yy"
//
//                let today = Date()
//                let s = formatter.string(from: today)
//                let d = formatter.date(from: s)
//
//                self.date = d
//        }
}
