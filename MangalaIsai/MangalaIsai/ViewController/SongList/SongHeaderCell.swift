//
//  SongHeaderCell.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 01/02/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class SongHeaderCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewHeightConstraint.constant =  UIScreen.main.bounds.height > UIScreen.main.bounds.width ?  UIScreen.main.bounds.height * 0.45 :  UIScreen.main.bounds.width * 0.45
        imgView.layoutIfNeeded()
       // let innerView = UIView(frame: imgView.frame)
        imgView.backgroundColor = UIColor.black
        imgView.addInnerShadow(onSide: UIView.innerShadowSide.bottom, shadowColor: UIColor.white, shadowSize: 15 ,shadowOpacity: 1)
        //contentView.addSubview(innerView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
