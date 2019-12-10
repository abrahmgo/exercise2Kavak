//
//  allGnomesViewController.swift
//  exercise2Kavak
//
//  Created by Flink on 12/9/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit

class allGnomesViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, dataFiler {
        
    @IBOutlet weak var filterView: filter!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionVIew: UICollectionView!
    var viewModel = gnomeViewModel()
    var searchActive : Bool = false
    var enableFilter  = false
    
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
        filterView.alpha = 0
        filterView.delegate = self
        searchBar.delegate = self
        if let layout = collectionVIew?.collectionViewLayout as? customLayout {
            layout.delegate = self
        }
        viewModel.downloadGnomes(withUrl: endPoint.server) { (_) in
            DispatchQueue.main.async {
                self.initValuesFilter()
                self.downLoadImages()
                self.collectionVIew.reloadData()
            }
        }
    }
    
    @IBAction func showFilter(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected
        {
            appearsFilter()
        }
        else
        {
            disappearFilter()
        }
    }
    
    func initValuesFilter()
    {
        filterView.minimumValueAge = viewModel.getMinAge()
        filterView.maximumValueAge = viewModel.getMaxAge()
        filterView.minimumValueHeight = viewModel.getMinHeight()
        filterView.maximumValueHeight = viewModel.getMaxHeight()
        filterView.minimumValueWeight = viewModel.getMinWeight()
        filterView.maximumValueWeight = viewModel.getMaxWeight()
        filterView.optionsProfessions = viewModel.getUniqueProfessions()
        filterView.optionsHairColor = viewModel.getUniqueHairColor()
    }
    
    func appearsFilter()
    {
        
        collectionVIew.isUserInteractionEnabled = false
        //filterView.isHidden = false
        filterView.isUserInteractionEnabled = true
        searchBar.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        searchBar.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5) {
            self.collectionVIew.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            self.filterView.alpha = 1
        }
    }
    
    func disappearFilter()
    {
        filterButton.isSelected = false
        collectionVIew.isUserInteractionEnabled = true
        //filterView.isHidden = true
        filterView.isUserInteractionEnabled = false
        searchBar.backgroundColor = UIColor.black.withAlphaComponent(0)
        searchBar.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.5) {
            self.collectionVIew.backgroundColor = UIColor.black.withAlphaComponent(0)
            self.filterView.alpha = 0
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
    
    func infoFilter(_ data: [String : Any]) {
        viewModel.getDataFilter(filters: data) { (flag) in
            if flag
            {
                self.enableFilter = true
                self.disappearFilter()
                DispatchQueue.main.async {
                    self.collectionVIew.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    self.collectionVIew.reloadData()
                }
            }
            else
            {
                DispatchQueue.main.async {
                    self.showAlertMessage(titleStr: "Gnome", messageStr: "Without results")
                }
            }
        }
        
    }
    
    func defaultFilter(_ flag: Bool) {
        enableFilter = false
        disappearFilter()
        DispatchQueue.main.async {
            self.collectionVIew.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self.collectionVIew.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumCellInSection(enableFilter: enableFilter, filter: searchActive)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! gnomeCollectionViewCell
        let gnomeIndex = viewModel.getGnomeAtIndex(enableFilter: enableFilter, filter: searchActive ,index: indexPath.row)
        let image = viewModel.getGnomeImageAtIndex(url: gnomeIndex.thumbnail!)
        cell.showTitle.text = gnomeIndex.name!
        cell.showImage.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return CGPoint(x: 0, y: -30)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionVIew.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gnomeIndex = viewModel.getGnomeAtIndex(enableFilter: enableFilter, filter: searchActive ,index: indexPath.row)
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
            self.collectionVIew.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            self.collectionVIew.reloadData()
        }
        self.view.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.getDataSearchBar(enableFilter: enableFilter,searchText: searchText) { (_) in
            let numItemsFilter = self.viewModel.getNumCellInSection(enableFilter: self.enableFilter, filter: true)
            if(numItemsFilter == 0){
                self.searchActive = false
            } else {
                self.searchActive = true
            }
            DispatchQueue.main.async {
                self.collectionVIew.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
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
