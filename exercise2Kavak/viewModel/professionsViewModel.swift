//
//  professionsViewModel.swift
//  exercise2Kavak
//
//  Created by Flink on 12/10/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation
import UIKit

class professionsViewModel{
    
    var dataSourceGnome : gnome
    
    init(infoGnome:gnome) {
        self.dataSourceGnome = infoGnome
    }
    
    func getNumCellInSection() -> Int
    {
        return dataSourceGnome.professions!.count
    }
    
    func getNameProfessions(index: Int) -> String
    {
        return dataSourceGnome.professions![index]
    }
    
    func getImageProfession(nameProfession: String) -> UIImage?
    {
        return UIImage(named: nameProfession)
    }
    
}
