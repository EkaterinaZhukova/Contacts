//
//  ListPresenter.swift
//  ContactsTask
//
//  Created by Екатерина on 11/13/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import Foundation
import Contacts

protocol ListPresenterDelegate:AnyObject {
    func showDetailFor(contact:CNContact)
    func showAddView()
}

class ListPresenter {
    
    private let view:ListView
    private let model:ListModel
    weak var delegate:ListPresenterDelegate?
    
    required init(view: ListView, model: ListModel) {
        self.model = model
        self.view = view
        model.presenter = self
    }
    
    func viewIsReady() {
        model.fetchData()
    }
    
    func modelUpdated() {
        let result = model.items.map { contact in
            return contact.givenName
        }
        view.present(list: result)
    }
    
    func openItemAt(index:Int) {
        let contact = model.items[index]
        delegate?.showDetailFor(contact: contact)
    }
    
    func openViewAddContact(){
        delegate?.showAddView()
    }
}
