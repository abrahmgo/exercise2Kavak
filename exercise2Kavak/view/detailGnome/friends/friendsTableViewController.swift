//
//  friendsTableViewController.swift
//  exercise2Kavak
//
//  Created by Flink on 12/10/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit

class friendsTableViewController: UITableViewController {

    var infoGnome : gnome?
    var viewModel : friendsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = friendsViewModel(infoGnome: infoGnome!)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel!.getNumCellInSection()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! friendsTableViewCell
        let nameFriend = viewModel!.getNameFriend(index: indexPath.row)
        cell.showTitle.text = nameFriend
        // Configure the cell...
        return cell
    }
    
}
