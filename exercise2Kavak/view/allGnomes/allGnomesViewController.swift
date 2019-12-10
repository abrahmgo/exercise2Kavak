//
//  allGnomesViewController.swift
//  exercise2Kavak
//
//  Created by Flink on 12/9/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit

class allGnomesViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionVIew: UICollectionView!
    var viewModel = gnomeViewModel()
    var searchActive : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVIew.delegate = self
        collectionVIew.dataSource = self
        initView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func initView()
    {
        searchBar.delegate = self
        if let layout = collectionVIew?.collectionViewLayout as? customLayout {
            layout.delegate = self
        }
        viewModel.downloadGnomes(withUrl: endPoint.server) { (_) in
            DispatchQueue.main.async {
                self.downLoadImages()
                self.collectionVIew.reloadData()
            }
        }
    }
    
    func downLoadImages()
    {
        viewModel.donwloadImages { (_) in
            DispatchQueue.main.async {
                self.collectionVIew.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumCellInSection(filter: searchActive)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! gnomeCollectionViewCell
        let gnomeIndex = viewModel.getGnomeAtIndex(filter: searchActive ,index: indexPath.row)
        let image = viewModel.getGnomeImageAtIndex(url: gnomeIndex.thumbnail!)
        cell.showTitle.text = gnomeIndex.name!
        cell.showImage.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return CGPoint(x: 0, y: -30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gnomeIndex = viewModel.getGnomeAtIndex(filter: searchActive ,index: indexPath.row)
        let image = viewModel.getGnomeImageAtIndex(url: gnomeIndex.thumbnail!)
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "detailGnome") as! detailGnomeViewController
        VC1.imageGnome = image
        VC1.infoGnome = gnomeIndex
        self.navigationController?.pushViewController(VC1, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        self.view.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        DispatchQueue.main.async {
            self.collectionVIew.reloadData()
        }
        self.view.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getDataSearchBar(searchText: searchText) { (_) in
            let numItemsFilter = self.viewModel.getNumCellInSection(filter: true)
            if(numItemsFilter == 0){
                self.searchActive = false
            } else {
                self.searchActive = true
            }
            DispatchQueue.main.async {
                self.collectionVIew.reloadData()
            }
        }
    }
    
}

extension allGnomesViewController: customLayoutDelegate
{
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        return 210.0
    }
}
