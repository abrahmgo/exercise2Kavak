//
//  mainViewController.swift
//  exercise2Kavak
//
//  Created by Flink on 12/10/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func allGnome(_ sender: UIButton) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "allGnome") as! allGnomesViewController
        self.navigationController?.pushViewController(VC1, animated: true)
    }
    
}
