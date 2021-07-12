//
//  SongListVC.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 01/02/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class SongListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: User Define Methods
extension SongListVC{
    @objc func deviceOrientationDidChange(_ notification: Notification) {
        self.setBackgroudImage(self.view!.frame.size)
        self.tableView.reloadData()
    }
    
    func setUpUI(){
        self.setBackgroudImage(self.view!.frame.size)
        tableView.register(UINib(nibName: "SongDetailCell", bundle: nil), forCellReuseIdentifier: "SongDetailCell")
    }
}

// MARK: tableView Delegate and Datasource
extension SongListVC:UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("frames table:",UITableView.automaticDimension)
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongDetailCell") as! SongDetailCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongHeaderCell") as! SongHeaderCell
        //cell.imgView.addShadow(to: [.bottom], radius: 5)
     
        return cell.contentView
    }
}
