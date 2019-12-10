//
//  detailGnomeViewController.swift
//  exercise2Kavak
//
//  Created by Flink on 12/9/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit

class detailGnomeViewController: UIViewController {

    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var favoriteGnome: UIButton!
    @IBOutlet weak var containerView: UIView!
    
    var viewModel = infoGnomeViewModel()
    var infoGnome : gnome?
    var imageGnome : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
    
    func initView()
    {
        showImage.image = imageGnome
        showTitle.text = infoGnome?.name
        let imageFavorite = viewModel.isFavoriteGnome(entityName: "GnomeEntity", infoGnome: infoGnome!)
        let nameImage = imageFavorite == true ? "favorite" : "nonFavorite"
        favoriteGnome.setBackgroundImage(UIImage(named: nameImage), for: .normal)
        favoriteGnome.isSelected = imageFavorite
        setupView(index:0)
    }

    @IBAction func favoriteGnomeAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let message = viewModel.statusFavoriteGnome(status: sender.isSelected, entityName: "GnomeEntity", infoGnome: infoGnome!)
        let imageFavorite = viewModel.isFavoriteGnome(entityName: "GnomeEntity", infoGnome: infoGnome!)
        let nameImage = imageFavorite == true ? "favorite" : "nonFavorite"
        favoriteGnome.setBackgroundImage(UIImage(named: nameImage), for: .normal)
        self.showAlertMessage(titleStr:"Gnome", messageStr:message)
    }
    
    func setupView(index: Int)
    {
        switch index {
        case 0:
            remove(asChildViewController: friendGnomeView)
            remove(asChildViewController: professionGnomeView)
            add(asChildViewController: infoGnomeView)
        case 1:
            remove(asChildViewController: infoGnomeView)
            remove(asChildViewController: professionGnomeView)
            add(asChildViewController: friendGnomeView)
        case 2:
            remove(asChildViewController: friendGnomeView)
            remove(asChildViewController: infoGnomeView)
            add(asChildViewController: professionGnomeView)
        default:
            print("error")
        }
    }
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChild(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParent: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParent: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParent()
    }
    
    private lazy var infoGnomeView: infoTableViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "info") as! infoTableViewController
        viewController.infoGnome = self.infoGnome!
        // Add View Controller as Child View Controller
        self.addChild(viewController)

        return viewController
    }()
    
    private lazy var professionGnomeView: professionsTableViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "professions") as! professionsTableViewController
        viewController.infoGnome = self.infoGnome!
        // Add View Controller as Child View Controller
        self.addChild(viewController)
        
        return viewController
    }()

    private lazy var friendGnomeView: friendsTableViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "friends") as! friendsTableViewController
        viewController.infoGnome = self.infoGnome!
        // Add View Controller as Child View Controller
        self.addChild(viewController)

        return viewController
    }()
}
