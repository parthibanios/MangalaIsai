//
//  MainAlbamCell.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 19/01/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit
import SDWebImage
protocol MainAlbamCellDelegate {
    //func tableViewReload()
}

class MainAlbamCell: UITableViewCell {

    @IBOutlet weak var collectionViewHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    var dashboardViewModel:DashboardViewModel!
    var delegate:MainAlbamCellDelegate! = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib.init(nibName: "MainAlbamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainAlbamCollectionViewCell")
//        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
//    deinit {
//         NotificationCenter.default.removeObserver(self)
//    }
//    @objc func deviceOrientationDidChange(_ notification: Notification) {
//        self.collectionView.reloadData()
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension MainAlbamCell:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dashboardViewModel.dashboardDetail.album_list.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width/2.3, height: self.frame.width/1.8)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainAlbamCollectionViewCell", for: indexPath)  as! MainAlbamCollectionViewCell
        self.setNeedsLayout()
        self.setNeedsDisplay()
        print("frames:",self.frame.width/2.1, self.collectionView.frame.width/2.1)
        let album = dashboardViewModel.dashboardDetail.album_list[indexPath.row]
        cell.albumImageView?.sd_setImage(with: URL(string: album.album_image!), placeholderImage: UIImage(named: "Image"))
        cell.albumName.text = album.album_name
        return cell
    }
}
