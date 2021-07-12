//
//  SubAlbamTableViewCell.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 19/01/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class SubAlbamTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionViewHeightConstrains: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var lblHeading: UILabel!
    var dashboardViewModel:DashboardViewModel!
    var indexPath:IndexPath!
    // MARK: - Cell initalization
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib.init(nibName: "SubAlbamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubAlbamCollectionViewCell")
        lblHeading.text = dashboardViewModel.albumTitleList[indexPath.row]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func viewAllBtnClickAction(_ sender: Any) {
    }
}


extension SubAlbamTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width/3.5, height: self.frame.width/3.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubAlbamCollectionViewCell", for: indexPath)
        self.setNeedsLayout()
        self.setNeedsDisplay()
        print("frames:",self.frame.width/2.1, self.collectionView.frame.width/2.1)
        
        return cell
    }
    
}

