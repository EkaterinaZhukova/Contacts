//
//  AddContactPresenter.swift
//  ContactsTask
//
//  Created by Екатерина on 11/14/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import Foundation
import Contacts

protocol AddContactDelegate:AnyObject {
    func succeedSave()
}

class AddContactPresenter{
    weak var view:AddView?
    weak var delegate:AddContactDelegate?
    
    required init(view:AddView?){
        self.view = view
    }
    
    func saveContact(contactName:String?,contactPhone:String?,contactEmail:String?) -> Bool{
        let contact = CNMutableContact()
        guard let name = contactName, let phone = contactPhone,let email = contactEmail else{
            return false
        }
        contact.givenName = name
        contact.phoneNumbers.append(CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue: phone)))
        contact.emailAddresses.append(CNLabeledValue(label: CNLabelHome, value: email as NSString))
        if(name == "" || (email == "" && phone == "")){
            return false
        }
        
        if(email != "" && email.contains("@") == false){
            return false
        }
        if(CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: phone)) == false){
            return false
        }
        
        let store = CNContactStore()
        let request = CNSaveRequest()
        request.add(contact, toContainerWithIdentifier: nil)
        
        do{
            try store.execute(request)
        }
        catch{
            return false
        }
        return true
        
        
    }
    
    func succeedSave(){
        delegate?.succeedSave()
    }
}
