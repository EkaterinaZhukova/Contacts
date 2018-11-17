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
    
    func checkContact(name:String?, phone:String?, email:String?) -> Bool{
        let validator = Validator()
        if(validator.validateContact(contactName: name, contactPhone: phone
            , contactEmail: email) == false){
            return false
        }
        return true
    }
    
    func saveContact(contactName:String?,contactPhone:String?,contactEmail:String?) -> Bool{
        let contact = CNMutableContact()

        let name = contactName ?? ""
        let phone = contactPhone ?? ""
        let email = contactEmail ?? ""
        
        contact.givenName = name
        contact.phoneNumbers.append(CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue: phone)))
        contact.emailAddresses.append(CNLabeledValue(label: CNLabelHome, value: email as NSString))

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
