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
    func updateContact(name:String?,phone:String?,email:String?) -> Bool{
        let previousName = contact.givenName
        let previousPhone = contact.phoneNumbers.first?.value.stringValue ?? ""
        let previousEmail = contact.emailAddresses.first?.value ?? ""
        if(phone == nil || name == nil || email == nil){
            return false
        }
        if(phone == "" && email == ""){
            return false
        }
        if(previousName == name && phone == previousPhone && email == (previousEmail as String)){
            return false
        }
        if(email != "" && email?.contains("@") == false){
            return false
        }
        if(CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: phone!)) == false){
            return false
        }

        
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
