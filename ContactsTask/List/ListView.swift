//
//  ListView.swift
//  ContactsTask
//
//  Created by Екатерина on 11/13/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import UIKit

class ListView: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var list:[String] = []
    weak var presenter:ListPresenter?
    let reuseID = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Phonebook"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(actionAddContact))
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @objc func actionAddContact(){
        presenter?.openViewAddContact()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewIsReady()
    }
    func present(list:[String]) {
        self.list = list
        self.tableView.reloadData()
    }
    func updateTableView(){
        self.tableView.reloadData()
    }
    func showAlertView(with mistake:String){
        let alert = UIAlertController(title: "Something went wrong", message: mistake, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    deinit {
        print("ListView deinit")
    }
}

extension ListView:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath)
        cell.textLabel?.text = item
        return cell
    }
    
    
}
extension ListView:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.openItemAt(index: indexPath.row)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
          presenter?.deleteItem(at: indexPath.row)
        }
    }
}
