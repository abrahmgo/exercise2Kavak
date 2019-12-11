//
//  infoTableViewCell.swift
//  exercise2Kavak
//
//  Created by Flink on 12/10/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit

class infoTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundCell: UIView!
    @IBOutlet weak var showTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCell.addShadowToCard(color: .black)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
