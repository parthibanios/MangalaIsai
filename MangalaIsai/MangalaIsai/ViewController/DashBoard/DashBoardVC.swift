//
//  DashBoardVC.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 18/01/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class DashBoardVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var dashboardViewModel:DashboardViewModel!
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialization()
    }
    
    func initialization()
    {
        self.setBackgroudImage(self.view!.frame.size)
        self.title = "My Music"
        self.tabBarItem.title = "DASHBOARD"
        var image = UIImage(named: "search")
        image = image?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:image , style: UIBarButtonItem.Style.plain, target: self, action: #selector(searchBtnClickAction))
        tableView.register(UINib.init(nibName: "MainAlbamCell", bundle: nil), forCellReuseIdentifier: "MainAlbamCell")
        tableView.register(UINib.init(nibName: "SubAlbamTableViewCell", bundle: nil), forCellReuseIdentifier: "SubAlbamTableViewCell")
        dashboardViewModel = DashboardViewModel(webservice: Webservice())
        dashboardViewModel.delegate = self
        dashboardViewModel.getDashbaordDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: User Define Methods
extension DashBoardVC{
    @objc func deviceOrientationDidChange(_ notification: Notification) {
        self.setBackgroudImage(self.view!.frame.size)
        self.tableView.setNeedsLayout()
        self.tableView.reloadData()
    }
    
    @objc func searchBtnClickAction()
    {
        
    }
}


// MARK: tableView Delegate and Datasource
extension DashBoardVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dashboardViewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("frames table:",UITableView.automaticDimension)
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainAlbamCell") as! MainAlbamCell
            cell.collectionViewHeightConstrains.constant = self.view.frame.width/1.8
            cell.dashboardViewModel = dashboardViewModel
            cell.collectionView.reloadData()
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubAlbamTableViewCell") as! SubAlbamTableViewCell
            cell.collectionViewHeightConstrains.constant = self.view.frame.width/3.5
            cell.indexPath = indexPath
            cell.dashboardViewModel = dashboardViewModel
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    
}

extension DashBoardVC:MainAlbamCellDelegate
{
   
    
}

extension DashBoardVC:DashboardViewModelDelegate{
    func apiError(error: String) {
        DispatchQueue.main.async {
            print(error)
            ProgressHUD.shared().hide()
            app_Delegate.alertViewController(title: "Warning", message: error, viewcontroller: self)
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            ProgressHUD.shared().show()
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            ProgressHUD.shared().hide()
            self.tableView.reloadData()
        }
    }
}
