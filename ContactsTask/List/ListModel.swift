//
//  ListModel.swift
//  ContactsTask
//
//  Created by Екатерина on 11/13/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import Foundation
import Contacts

class ListModel {
    
    private (set) var items:[CNContact] = []
    private let store:CNContactStore
    
    weak var presenter:ListPresenter?
    
    init() {
        store = CNContactStore()
    }

    func deleteItem(at index:Int){
        let request = CNSaveRequest()
        let contact = items[index].mutableCopy() as! CNMutableContact
        let store = CNContactStore()
        request.delete(contact)
        if let _ = try? store.execute(request){
            items.remove(at: index)
            presenter?.modelUpdated()
        }
    }
    func fetchData() {
        let request = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor, CNContactEmailAddressesKey as CNKeyDescriptor])
        var result:[CNContact] = []
        try? store.enumerateContacts(with: request) { contact, _ in
            result.append(contact)
        }
        items = result
        presenter?.modelUpdated()
    }
}
