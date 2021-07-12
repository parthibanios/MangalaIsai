//
//  NavigationViewController.swift
//  SampleLeftMenu
//
//  Created by PARTHIBAN on 12/01/19.
//  Copyright © 2019 PARTHIBAN. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {
    var isFavorite:Bool = true
    var isprivacy:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = UIColor.clear
        self.navigationBar.tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
          UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        //self.title
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
