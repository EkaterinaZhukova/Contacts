//
//  AppDelegate.swift
//  ContactsTask
//
//  Created by Екатерина on 11/11/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

import UIKit
import Contacts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let model = ListModel()
    var rootPresenter:ListPresenter!
    let mainNavigationController = UINavigationController(rootViewController: UIViewController())
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var detailPresenter:DetailPresenter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        let listController = storyboard.instantiateViewController(withIdentifier: "ListView") as! ListView
        rootPresenter = ListPresenter(view: listController, model: model)
        listController.presenter = rootPresenter
        rootPresenter.delegate = self
        
        
        
        mainNavigationController.viewControllers = [listController]
        window?.rootViewController = mainNavigationController
        window?.makeKeyAndVisible()
        let store = CNContactStore()
        store.requestAccess(for: .contacts) {
            r, e in
            
        }
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

extension AppDelegate:ListPresenterDelegate{
    func showAddView() {
        let view = storyboard.instantiateViewController(withIdentifier: "AddView") as! AddView
        let presenterAddView = AddContactPresenter(view: view)
        presenterAddView.delegate = self
        view.presenter = presenterAddView
        mainNavigationController.pushViewController(view, animated: true)
    }
    
    func showDetailFor(contact:CNContact) {
        let detailView = storyboard.instantiateViewController(withIdentifier: "DetailView") as! DetailView
        detailPresenter = DetailPresenter(view: detailView, contact: contact)
        detailPresenter?.delegate = self
        detailView.presenter = detailPresenter
        mainNavigationController.pushViewController(detailView, animated: true)
    }
}
extension AppDelegate:DetailPresenterDelegate{
    func showViewEditContact(for contact: CNContact) {
        let editView = storyboard.instantiateViewController(withIdentifier: "EditView") as! EditView
        let editPresenter = EditPresenter(view: editView, contact: contact)
        editPresenter.delegate = self
        editView.presenter = editPresenter
        mainNavigationController.pushViewController(editView, animated: true)
    }
    
    
}
extension AppDelegate:EditPresenterDelegate{
    func contactWasEditedSuccessfully(newModel:CNContact) {
        detailPresenter?.setModel(for: newModel)
        mainNavigationController.popViewController(animated: false)
        self.mainNavigationController.popViewController(animated: true)
    }
}

extension AppDelegate:AddContactDelegate{
    func succeedSave() {
        self.mainNavigationController.popViewController(animated: true)
    }
    
}
