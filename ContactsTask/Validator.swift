//
//  Validator.swift
//  ContactsTask
//
//  Created by Екатерина on 11/17/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import Foundation
import Contacts

class Validator{
    private func validateEmail(for email:String) -> Bool{
        if(email != "" && email.contains("@") == false){
            return false
        }
        return true
    }
    
    private func validatePhone(for phone:String) -> Bool{
        if(CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: phone)) == false){
            return false
        }
        return true
    }
    
    func validateContact(contactName: String?, contactPhone:String?, contactEmail: String?) -> Bool{
        guard let name = contactName,let phone = contactPhone,let email = contactEmail else{
            return false
        }
        if(name == "" || (email == "" && phone == "")){
            return false
        }
        if(validateEmail(for: email as String) == false){
            return false
        }
        if(validatePhone(for: phone) == false){
            return false
        }
        
        return true
    }
    
    func validateContact(contactName:String?, contactPhone:String?, contactEmail:String?, contact: CNContact) -> Bool{
        let previousName = contact.givenName
        guard let previousPhone = contact.phoneNumbers.first?.value.stringValue, let previousEmail = contact.emailAddresses.first?.value else{
            return false
        }
        
        if(self.validateContact(contactName: contactName, contactPhone: contactPhone, contactEmail: contactEmail) == false){
            return false
        }
        if(previousName == contactName && previousPhone == contactPhone && previousEmail as String == contactEmail){
            return false
        }
        return true
    }
}
