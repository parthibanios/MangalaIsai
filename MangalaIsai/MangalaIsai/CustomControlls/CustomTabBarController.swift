//
//  CustomTabBarController.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 18/01/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {

    var titleList = ["Albums","Events","About","More"]
    override func viewDidLoad() {
        super.viewDidLoad()
      //  self.viewControllers?[0].tabBarItem.title = "Albums"
    }
}

extension CustomTabBarController:UITabBarControllerDelegate
{
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        viewController.tabBarItem.title = titleList[viewController.tabBarItem.tag]        //        if viewController.tabBarItem.tag == 4
        //        {
        //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //            let popoverContentController = self.storyboard?.instantiateViewController(withIdentifier: "MoreVC") as? MoreVC
        //            popoverContentController?.modalPresentationStyle = .popover
        //            popoverContentController?.preferredContentSize = CGSize(width: 300, height: 200)
        //            /* 3 */
        //            if let popoverPresentationController = popoverContentController?.popoverPresentationController {
        //                popoverPresentationController.delegate = self
        //                popoverPresentationController.permittedArrowDirections = .up
        //                popoverPresentationController.sourceView = viewController.tabBarController?.tabBar
        //                popoverPresentationController.sourceRect = (viewController.tabBarController?.tabBar.bounds)!
        //                if let popoverController = popoverContentController {
        //                    present(popoverController, animated: true, completion: nil)
        //                }
        //            }
        //
        //        }
    }
}
