//
//  TableViewController.swift
//  ReSwiftCoreData
//
//  Created by UetaMasamichi on 9/21/16.
//  Copyright © 2016 MasamichiUeta. All rights reserved.
//

import UIKit
import ReSwift

class TableViewController: UITableViewController, StoreSubscriber {

    var users: [User]!
    
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
        
        self.users = state.users
        self.tableView.reloadData()

    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let user = self.users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = "\(user.age)"
        
        return cell
    }


    @IBAction func addButtonDidTap(_ sender: AnyObject) {
        let user = User(context: appDelegate.persistentContainer.viewContext)
        user.name = "Albert Einstein"
        user.age = 78
        appDelegate.saveContext()
        
        //Dispatch Action
        appDelegate.mainStore.dispatch(AddUser(user: user))
        
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show" {
            let vc = segue.destination as! DetailViewController
            vc.user = self.users[self.tableView.indexPathForSelectedRow!.row]
        }
    }


}
