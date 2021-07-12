//
//  AlbumListVC.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 25/01/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class AlbumListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    let mainAlbumList = ["vinayagar", "ram", "Murugam", "jai sri ram"]
    
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
extension AlbumListVC{
    @objc func deviceOrientationDidChange(_ notification: Notification) {
        self.setBackgroudImage(self.view!.frame.size)
    }
    
    func setUpUI(){
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        self.setBackgroudImage(self.view!.frame.size)
        
        collectionView.register(UINib(nibName: "MainAlbumCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainAlbumCollectionViewCell")
    }
}

// MARK: tableView Delegate and Datasource
extension AlbumListVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("frames table:",UITableView.automaticDimension)
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumTableViewCell") as! AlbumTableViewCell
        return cell
    }
}

extension AlbumListVC:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainAlbumList.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return UICollectionViewFlowLayout.automaticSize
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainAlbumCollectionViewCell", for: indexPath) as! MainAlbumCollectionViewCell
       cell.titleLbl.text = mainAlbumList[indexPath.row]
        cell.titleBaseView.layoutIfNeeded()
        cell.titleBaseView.addShadow(cell.titleBaseView.frame.height/2)
         cell.imageBaseView.addShadow(cell.imageBaseView.frame.height/2)
        print("frames:",cell.imageBaseView.frame.width, cell.imageBaseView.frame.height)
        
        return cell
    }
}
