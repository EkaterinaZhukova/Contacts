//
//  AddView.swift
//  ContactsTask
//
//  Created by Екатерина on 11/14/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import UIKit

class AddView: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    var saveButton:UIBarButtonItem?
    
    var presenter:AddContactPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameTextField.addTarget(self, action: #selector(changedTextFields), for: .editingChanged)
        self.phoneTextField.addTarget(self, action: #selector(changedTextFields), for: .editingChanged)
        self.emailTextField.addTarget(self, action: #selector(changedTextFields), for: .editingChanged)

        self.navigationItem.rightBarButtonItem = nil
            saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(actionSaveContact))
        title = "Add"
    }
    @objc func actionSaveContact(){
        if(presenter == nil){
            
        }
        if(presenter?.saveContact(contactName: nameTextField.text, contactPhone: phoneTextField.text, contactEmail: emailTextField.text) == false){
            let alert = UIAlertController(title: "Saving error", message: "Something went wrong while saving contact, try later.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
        else{
            presenter?.succeedSave()
        }
    }
    deinit {
        print("AddView deinit")
    }
    
    
    @objc func changedTextFields(){
        if(presenter?.checkContact(name: nameTextField.text, phone: phoneTextField.text, email: emailTextField.text) == true){
            self.navigationItem.rightBarButtonItem = saveButton
        }
        else{
            self.navigationItem.rightBarButtonItem = nil
        }
        
    }

}
