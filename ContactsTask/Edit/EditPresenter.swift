//
//  EditPresenter.swift
//  ContactsTask
//
//  Created by Екатерина on 11/13/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import Foundation
import Contacts


protocol EditPresenterDelegate:AnyObject {
    func contactWasEditedSuccessfully(newModel: CNContact)
}

class EditPresenter{
    weak var view:EditView?
    weak var delegate: EditPresenterDelegate?
    var contact:CNContact
    
    required init(view:EditView,contact:CNContact){
        self.view = view
        self.contact = contact
    }
    
    func viewIsReady(){
        let name = contact.givenName
        let phone = contact.phoneNumbers.first?.value.stringValue ?? ""
        let email = contact.emailAddresses.first?.value ?? ""
        view?.updateViewWith(name: name, phone: phone, email: email as String)
    }
    func checkContact(name:String?,phone:String?,email:String?) -> Bool{
        let validator = Validator()
        if(validator.validateContact(contactName: name, contactPhone: phone, contactEmail: email,contact: contact) == false){
            return false
        }
        return true
    }
    func updateContact(name:String?,phone:String?,email:String?) -> Bool{
        if let mutableContact = contact.mutableCopy() as? CNMutableContact{
            mutableContact.givenName = name!
            mutableContact.phoneNumbers[0] = CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue: phone!))
            mutableContact.emailAddresses[0] = CNLabeledValue(label: CNLabelHome, value: email! as NSString)
            let request = CNSaveRequest()
            let store = CNContactStore()
            request.update(mutableContact)
            do{
                try store.execute(request)
                
            }
            catch{
                return false
            }
            contact = mutableContact
            delegate?.contactWasEditedSuccessfully(newModel: contact)
            return true
        }
        return false
    }
}
