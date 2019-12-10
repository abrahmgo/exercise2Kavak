//
//  ViewController.swift
//  exercise2Kavak
//
//  Created by Flink on 12/9/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionVIew: UICollectionView!
    var viewModel = gnomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVIew.delegate = self
        collectionVIew.dataSource = self
        viewModel.downloadGnomes(withUrl: endPoint.server) { (_) in
            DispatchQueue.main.async {
                self.collectionVIew.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumCellInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let gnomeIndex = viewModel.getGnomeAtIndex(index: indexPath.row)
        print(gnomeIndex.age)
        return cell
    }

}

