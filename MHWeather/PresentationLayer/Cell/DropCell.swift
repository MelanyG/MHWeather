//
//  DropCell.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/23/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class DropCell: UICollectionViewCell {
    
  @IBOutlet weak var partOfDay: UILabel!
  @IBOutlet weak var chanceOfRain: UILabel!
  @IBOutlet weak var dropView: DropView!
    
    func resetAnimation() {
        dropView.resetAnimation()
    }
    
    

}
