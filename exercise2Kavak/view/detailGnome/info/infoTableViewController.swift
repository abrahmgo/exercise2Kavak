//
//  infoTableViewController.swift
//  exercise2Kavak
//
//  Created by Flink on 12/10/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit

class infoTableViewController: UITableViewController {

    var viewModel : infoViewModel?
    var infoGnome : gnome?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = infoViewModel(infoGnome: infoGnome!)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! infoTableViewCell
        let nameKey = viewModel!.getKeyInfoGnome(index: indexPath.row)
        let nameValue = viewModel!.getValueInfoGnome(index: indexPath.row)
        cell.showTitle.text = nameKey + " " + nameValue
        // Configure the cell...

        return cell
    }

}
