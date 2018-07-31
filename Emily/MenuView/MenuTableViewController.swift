//
//  MenuTableViewController.swift
//  Emily
//
//  Created by popCorn on 2018/06/30.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit 

class MenuTableViewController: UITableViewController {
    
    // khai bao kieu mang du lieu dictionary cua du lieu
    var bookmarks : Array<Dictionary<String,String>> = allBookmarks
    //**************************************************
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     
}

// viewcontroller datasource and delegate
extension MenuTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookmarks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MenuTableViewCell
        let bookmark = bookmarks[indexPath.row]
        cell.titleCell.text = bookmark["title"]!.uppercased()
        cell.price.text = "Price: $" + bookmark["price"]!
        cell.ratingStar.text = bookmark["ratingStar"]! + " star"
        cell.onSale.text = bookmark["onSale"]
        if cell.onSale.text == "stop" {
            cell.onSale.textColor = UIColor.gray
        }
        cell.like.text = bookmark["like"]! + " like"
        cell.imageCell.image = UIImage(named: bookmark["imageCell"]!)
        cell.imageCell.layer.cornerRadius =  cell.imageCell.frame.width / 2
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail", let destination = segue.destination as? MenuViewController {
            destination.section = sections[0]
            destination.sections = sections
            destination.indexPath = sender as! IndexPath
        }
    }
    
    
    
}
public extension UIViewController {
    
}

