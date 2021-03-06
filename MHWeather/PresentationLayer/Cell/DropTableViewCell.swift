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
    var animationReset = false

    
    override func awakeFromNib() {
        super.awakeFromNib()
        colView.delegate = self
        colView.dataSource = self
        

        // Initialization code
    }
    
    override func prepareForReuse() {
       animationReset = true
        colView.reloadData()
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
        let hour: HourForecast = dataSource[indexPath.item * 6] as! HourForecast
        cell.partOfDay.text = getpartOfTheDay(currentTime: hour.hour!)

        if hour.pop == nil {
            cell.dropView.dropLevel = 0
            cell.chanceOfRain.text = "Chance 0%"
        } else {
            cell.dropView.dropLevel = CGFloat(hour.pop!) / 100
            cell.chanceOfRain.text = "Chance \(hour.pop!)%"
        }

        if animationReset {
            cell.resetAnimation()
        }

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
    
    func getpartOfTheDay(currentTime:Int) -> String{
        switch currentTime {
        case 1...4: return Constants.dayParts[5]
        case 4...8: return Constants.dayParts[0]
        case 9...13: return Constants.dayParts[1]
        case 14...18: return Constants.dayParts[2]
        case 19...22: return Constants.dayParts[3]
        case 23: return Constants.dayParts[4]
        default: return Constants.dayParts[4]
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

