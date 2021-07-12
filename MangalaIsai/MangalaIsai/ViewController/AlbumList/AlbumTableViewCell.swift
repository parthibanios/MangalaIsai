//
//  AlbumTableViewCell.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 01/02/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet var totalSongLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
