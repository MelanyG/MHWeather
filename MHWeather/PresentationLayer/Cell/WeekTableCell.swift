//
//  WeekTableCell.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/21/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class WeekTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: - Properties
    
    @IBOutlet weak var colView: UICollectionView!
    var dataSourse = Array<DayWeather>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib.init(nibName: "DayCell", bundle: nil)
        colView.register(nib, forCellWithReuseIdentifier: Constants.reuseIdentifier)
        let nibHeader = UINib.init(nibName: "DashHeader", bundle: nil)
        colView.register(nibHeader, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: Constants.headerReuseIdentifier)
        
        colView.delegate = self
        colView.dataSource = self
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    struct Constants{
        static let reuseIdentifier = "DayCell"
        static let headerReuseIdentifier = "DashSeparator"
        static let itemsPerRow: CGFloat = 5
        static let sectionInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    //1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath) as! DayCell
        if indexPath.section == 2 {
            let day = dataSourse[4 + indexPath.item] as DayWeather
            cell.setUpCell(withDay: day)
        } else {
            let day = dataSourse[indexPath.item] as DayWeather
            cell.setUpCell(withDay: day)
        }
        cell.backgroundColor = UIColor.clear
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        //1
        switch kind {
        //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: Constants.headerReuseIdentifier,
                                                                             for: indexPath) as! DashHeader
            //  headerView.label.text = searches[(indexPath as NSIndexPath).section].searchTerm
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }
}

extension WeekTableCell : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = Constants.sectionInsets.left * (Constants.itemsPerRow + 1)
        let availableWidth = self.frame.width - paddingSpace
        let widthPerItem = availableWidth / Constants.itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.sectionInsets
    }
    
    // 4
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.sectionInsets.left
    }
}

class DashHeader: UICollectionReusableView {
    
}
