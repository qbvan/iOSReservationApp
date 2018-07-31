//
//  ListTableViewController.swift
//  Emily
//
//  Created by popCorn on 2018/07/23.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ListTableViewController: UITableViewController {
    var ref: DatabaseReference!
    var databaseHandle: DatabaseHandle!
    var listBookArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //retrieve data when data change
        
        databaseHandle = ref?.child("bookTable").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? String
            if let item = post {
                self.listBookArray.append(item)
                self.tableView.reloadData()
            }
        })
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listBookArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListTableViewCell
        cell.titleCell.text = listBookArray[indexPath.row]

        return cell
    }
}
