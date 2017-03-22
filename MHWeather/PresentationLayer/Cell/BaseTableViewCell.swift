//
//  BaseTableViewCell.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/10/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {


    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var graphView: GraphView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
