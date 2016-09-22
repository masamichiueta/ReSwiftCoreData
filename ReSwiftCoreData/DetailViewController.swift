//
//  DetailViewController.swift
//  ReSwiftCoreData
//
//  Created by UetaMasamichi on 9/21/16.
//  Copyright © 2016 MasamichiUeta. All rights reserved.
//

import UIKit
import ReSwift

class DetailViewController: UIViewController, StoreSubscriber{

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.mainStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        appDelegate.mainStore.unsubscribe(self)
    }
    
    func newState(state: AppState) {
        
        guard let currentUser = state.users.filter({
            $0.objectID.isEqual(self.user.objectID)
        }).first else {
            return
        }

        self.user = currentUser
        
        if self.user.name == "" || self.user.age < 0 {
            self.saveButton.isEnabled = false
        } else {
            self.saveButton.isEnabled = true
            self.nameTextField.text = self.user.name
            self.ageTextField.text = "\(self.user.age)"
        }
    }
    
    @IBAction func saveButtonDidTap(_ sender: AnyObject) {
        appDelegate.saveContext()
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nameTextFieldEditingChanged(_ sender: UITextField) {
        self.user.name = sender.text
        appDelegate.mainStore.dispatch(UpdateUser(user: self.user))
    }
    
    
    @IBAction func ageTextFieldEditingChanged(_ sender: UITextField) {
        self.user.age = Int16(sender.text!) ?? -1
        appDelegate.mainStore.dispatch(UpdateUser(user: self.user))
    }
}
