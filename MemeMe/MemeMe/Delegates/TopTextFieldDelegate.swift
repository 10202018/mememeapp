//
//  TextFieldDelegate.swift
//  MemeMe
//
//  Created by TJ on 11/28/18.
//  Copyright © 2018 TJ. All rights reserved.
//

import UIKit

class TopTextFieldDelegate: NSObject, UITextFieldDelegate {
    var changedTextValue: Bool = false
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard changedTextValue == true else {
            changedTextValue = true
            textField.text = ""
            return true
        }
        
        return true
        
        
        /*
        CUSTOM WORD RESTRICTION IN TEXT FIELD
        
        guard changedTextValue == true else {
            changedTextValue = true
            return true
        }
        
        var textToBeSaved: String = ""
        if let textFieldText = textField.text {
            textToBeSaved = textFieldText + string
            if textToBeSaved.contains("TOP") {
                return false
            }
        }
        return true
         */
    }
 
    
    
}
