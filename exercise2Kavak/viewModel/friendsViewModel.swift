//
//  friendsViewModel.swift
//  exercise2Kavak
//
//  Created by Flink on 12/10/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation


class friendsViewModel{
    
    var dataSourceGnome : gnome
    
    init(infoGnome:gnome) {
        self.dataSourceGnome = infoGnome
    }
    
    func getNumCellInSection() -> Int
    {
        return dataSourceGnome.friends!.count
    }
    
    func getNameFriend(index: Int) -> String
    {
        return dataSourceGnome.friends![index]
    }
    
}
