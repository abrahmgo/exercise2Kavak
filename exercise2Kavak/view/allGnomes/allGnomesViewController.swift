//
//  allGnomesViewController.swift
//  exercise2Kavak
//
//  Created by Flink on 12/9/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit

class allGnomesViewController: UIViewController,  UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionVIew: UICollectionView!
    var viewModel = gnomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVIew.delegate = self
        collectionVIew.dataSource = self
        initView()
        // Do any additional setup after loading the view.
    }
    
    func initView()
    {
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
            self.collectionVIew.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumCellInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! gnomeCollectionViewCell
        let gnomeIndex = viewModel.getGnomeAtIndex(index: indexPath.row)
        let image = viewModel.getGnomeImageAtIndex(url: gnomeIndex.thumbnail!)
        cell.showTitle.text = gnomeIndex.name!
        cell.showImage.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return CGPoint(x: 0, y: -30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gnomeIndex = viewModel.getGnomeAtIndex(index: indexPath.row)
        let image = viewModel.getGnomeImageAtIndex(url: gnomeIndex.thumbnail!)
        let VC1 = self.storyboard!.instantiateViewController(withIdentifier: "detailGnome") as! detailGnomeViewController
        VC1.imageGnome = image
        VC1.infoGnome = gnomeIndex
        self.navigationController?.pushViewController(VC1, animated: true)
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
