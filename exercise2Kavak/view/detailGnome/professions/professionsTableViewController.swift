//
//  professionsTableViewController.swift
//  exercise2Kavak
//
//  Created by Flink on 12/10/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit

class professionsTableViewController: UITableViewController {

    var viewModel : professionsViewModel?
    var infoGnome : gnome?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = professionsViewModel(infoGnome: infoGnome!)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! professionTableViewCell
        let nameProfesion = viewModel!.getNameProfessions(index: indexPath.row)
        let nameImage = viewModel!.getImageProfession(nameProfession: nameProfesion)
        cell.showTitle.text = nameProfesion
        cell.showImage.image = nameImage
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62.0
    }
}
