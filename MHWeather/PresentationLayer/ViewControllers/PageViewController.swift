//
//  PageViewController.swift
//  MHWeather
//
//  Created by Melaniia Hulianovych on 3/17/17.
//  Copyright © 2017 Melaniia Hulianovych. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.setViewControllers([getViewControllerAtIndex(index: 0)] as [StartViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK DataSource
    
   func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let startContent: StartViewController = viewController as! StartViewController
        var index = startContent.pageIndex
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        index -= 1
        return getViewControllerAtIndex(index: index)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let pageContent: StartViewController = viewController as! StartViewController
        var index = pageContent.pageIndex
        if (index == NSNotFound) {
            return nil
        }
        index += 1
        if index == DataSource.sharedDataSource.locationPoints.count || index < 2 {
            return nil
        }
        return getViewControllerAtIndex(index: index)

    }
    
    func getViewControllerAtIndex(index: NSInteger) -> StartViewController? {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "StartViewController") as! StartViewController
        guard let locObj = DataSource.sharedDataSource.locationPoints[index] else { return nil }
        pageContentViewController.visualLocation = locObj

        pageContentViewController.currentCityForecast = DataSource.sharedDataSource.citiesForecast[locObj.textLbl]
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PageViewController: LocationSelectionDelegate {
    func locationSelected(newLocation: LocationCellObject, selectedIndex:Int) {
//        visualLocation = newLocation
//        pageIndex = selectedIndex
//        conMan?.downloadByLocationObject(object: visualLocation!) {
//            [unowned self] (result: CityForecastObject?) in
//            guard let keyCity = self.visualLocation?.textLbl else { return }
//            self.currentCityForecast = result
//            DispatchQueue.main.async {
//                self.weatherTableView.reloadData()
//                self.navBar.cityName.text = keyCity
//            }
//            DataSource.sharedDataSource.citiesForecast[keyCity] = result
//        }
        
        //        guard let keyCity = visualLocation?.textLbl else { return }
        //        currentCityForecast = DataSource.sharedDataSource.citiesForecast[keyCity]!
        
    }
}
