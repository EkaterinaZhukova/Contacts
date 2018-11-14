//
//  DetailView.swift
//  ContactsTask
//
//  Created by Екатерина on 11/13/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import UIKit

class DetailView: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emilLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    var presenter:DetailPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editContact))
    }
    @objc func editContact(){
        presenter?.showViewEditContact()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if(presenter == nil){
            print("Nil")
        }
        presenter?.viewIsReady()
    }
    func updateViewWithData(name:String?,phone:String?,email:String?){
        self.nameLabel.text = name
        self.phoneLabel.text = phone
        self.emilLabel.text = email
    }
    deinit{
        print("DetailView deinit")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
