//
//  EditView.swift
//  ContactsTask
//
//  Created by Екатерина on 11/13/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import UIKit

class EditView: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    var saveButton:UIBarButtonItem?
    var presenter:EditPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Edit"
        self.nameTextField.addTarget(self, action: #selector(changedTextFields), for: .editingChanged)
        self.phoneTextField.addTarget(self, action: #selector(changedTextFields), for: .editingChanged)
        self.emailTextField.addTarget(self, action: #selector(changedTextFields), for: .editingChanged)

        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEditedContact))
       
    }
    @objc func saveEditedContact(){
        let res = presenter?.updateContact(name: nameTextField.text, phone: phoneTextField.text, email: emailTextField.text)
        if(res == false){
            let alert = UIAlertController(title: "Saving error", message: "Something went wrong while saving, try later.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewIsReady()
        
    }
    func updateViewWith(name:String?,phone:String?,email:String?){
        self.nameTextField.text = name
        self.phoneTextField.text = phone
        self.emailTextField.text = email
    }
 
    @objc func changedTextFields(){
        if(presenter?.checkContact(name: nameTextField.text, phone: phoneTextField.text, email: emailTextField.text) == true){
            self.navigationItem.rightBarButtonItem = saveButton
        }
        else{
            self.navigationItem.rightBarButtonItem = nil
        }
        
    }
    
    deinit {
        print("Edit View deinit")
    }

}

