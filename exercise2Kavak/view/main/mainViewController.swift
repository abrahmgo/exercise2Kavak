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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    @IBAction func allGnome(_ sender: UIButton) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "allGnome") as! allGnomesViewController
        VC1.useFlag = 1
        self.navigationController?.pushViewController(VC1, animated: true)
    }
    
    @IBAction func favoriteGnome(_ sender: UIButton) {
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "allGnome") as! allGnomesViewController
        VC1.useFlag = 0
        self.navigationController?.pushViewController(VC1, animated: true)
    }
    
}
