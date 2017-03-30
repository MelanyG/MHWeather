//
//  DropTableViewCell.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/23/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class DropTableViewCell: BaseTableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    var dataSource = Array<Any>()
    var currentTime: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colView.delegate = self
        colView.dataSource = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    struct Constants{
        static let reuseIdentifier = "DropCell"
        static let headerReuseIdentifier = "DashHeaderSeparator"
        static let footerReuseIdentifier = "DashFooterSeparator"
        static let dayParts = ["Early Morning", "Morning", "Afternoon", "Evening", "Night", "Overnight"]
        static let itemsPerRow: CGFloat = 4
        static let sectionInsets = UIEdgeInsets(top: 0.0, left: 30.0, bottom: 0.0, right: 20.0)
        
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    //1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath) as! DropCell
        cell.partOfDay.text = Constants.dayParts[currentTime + indexPath.item]
        cell.chanceOfRain.text = "25%"
        if indexPath.item % 2 == 0 {
            cell.dropView.dropLevel = 0.25
        }
//            let day = dataSource[4 + indexPath.item] as DayWeather
//            cell.setUpCell(withDay: day)

//        cell.backgroundColor = UIColor.red
        
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
                                                                             for: indexPath)
            return headerView
        case UICollectionElementKindSectionFooter:
            //3
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: Constants.footerReuseIdentifier,
                                                                             for: indexPath)
            return footerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }
}

extension DropTableViewCell : UICollectionViewDelegateFlowLayout {
    //1
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let paddingSpace = Constants.sectionInsets.left * (Constants.itemsPerRow + 1 )
        let availableWidth = self.colView.frame.size.width - paddingSpace
        let widthPerItem = availableWidth / Constants.itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem * 1.2)
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

