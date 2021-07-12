//
//  MainAlbumCollectionViewCell.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 25/01/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class MainAlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var titleBaseView: SimpleShadowedView!
    @IBOutlet weak var imageBaseView: SimpleShadowedView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        albumImageView.layer.cornerRadius = albumImageView.frame.width/2
        imageBaseView.layer.cornerRadius = imageBaseView.frame.width/2
        
    }

}
