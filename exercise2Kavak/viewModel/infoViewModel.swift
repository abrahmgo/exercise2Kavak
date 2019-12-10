//
//  infoViewModel.swift
//  exercise2Kavak
//
//  Created by Flink on 12/10/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation

class infoViewModel{
    var dataSourceGnome : gnome
    var arrInfoGnome = [String]()
    var keyInfoGnome = ["Name","Age","Hair Color","Height","Weight"]
    
    init(infoGnome:gnome) {
        self.dataSourceGnome = infoGnome
        fullData()
    }
    
    private func fullData()
    {
        arrInfoGnome.append(dataSourceGnome.name!)
        arrInfoGnome.append(String(dataSourceGnome.age!))
        arrInfoGnome.append(dataSourceGnome.hairColor!)
        arrInfoGnome.append(String(dataSourceGnome.height!))
        arrInfoGnome.append(String(dataSourceGnome.weight!))
        
    }
    
    func getNumCellInSection() -> Int
    {
        return arrInfoGnome.count
    }
    
    func getKeyInfoGnome(index: Int) -> String
    {
        return keyInfoGnome[index]
    }
    
    func getValueInfoGnome(index: Int) -> String
    {
        return arrInfoGnome[index]
    }
}
