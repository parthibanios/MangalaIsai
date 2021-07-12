//
//  SongDetailCell.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 01/02/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class SongDetailCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var durationLbl: UILabel!
    @IBOutlet var likeBtn: UIButton!
    @IBOutlet var downlaodBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
