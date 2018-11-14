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
    
    var presenter:AddContactPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(actionSaveContact))
        title = "Add"
    }
    @objc func actionSaveContact(){
        if(presenter == nil){
            
        }
        if(presenter?.saveContact(contactName: nameTextField.text, contactPhone: phoneTextField.text, contactEmail: emailTextField.text) == false){
            let alert = UIAlertController(title: "Incorrect input", message: "It's recommended you to check all fields.", preferredStyle: .alert)
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

}
