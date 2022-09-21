//
//  ValidationsTextField.swift
//  VeriPark
//
//  Created by sameeltariq on 16/09/2022.
//

import UIKit
enum ValueType : Int{
    case none
    
    case onlyNumbers
    
    case alphaNumeric
    
}
class ValidationsTextField: UITextField {

        @IBInspectable var maxLength : Int = 0
        var valueType : ValueType = ValueType.alphaNumeric
    
        func verifyFields(shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            switch valueType {
            case .none:
                break // Do nothing
            case .onlyNumbers:
                let numberSet = CharacterSet.decimalDigits
                if string.rangeOfCharacter(from: numberSet.inverted) != nil {
                    return false
                }
            case .alphaNumeric:
                let alphaNumericSet = CharacterSet.alphanumerics
                if string.rangeOfCharacter(from: alphaNumericSet.inverted) != nil {
                    return false
                }
            }
            return true
        }
        
    }
  
