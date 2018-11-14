//
//  DetailPresenter.swift
//  ContactsTask
//
//  Created by Екатерина on 11/13/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import Foundation
import Contacts
protocol DetailPresenterDelegate:AnyObject {
    func showViewEditContact(for contact:CNContact)
}
class DetailPresenter{
    private let view:DetailView
    private var model:CNContact
    weak var delegate:DetailPresenterDelegate?
    
    func setModel(for model:CNContact){
        self.model = model
    }
    required init(view:DetailView, contact:CNContact) {
        self.view = view
        model = contact
    }
    
    func viewIsReady() {
        let name = "Name: \(model.givenName)"
        let phoneNumber = "Phone: \(model.phoneNumbers.first?.value.stringValue ?? "")"
        let emailNumber = "Email: \(model.emailAddresses.first?.value ?? "")"
        view.updateViewWithData(name: name, phone: phoneNumber, email: emailNumber)
        
    }
    
    func showViewEditContact(){
        delegate?.showViewEditContact(for: model)
    }
}
