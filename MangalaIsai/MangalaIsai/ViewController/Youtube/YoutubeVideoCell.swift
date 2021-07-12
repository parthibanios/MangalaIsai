//
//  YoutubeVideoCell.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 02/02/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class YoutubeVideoCell: UITableViewCell {

    @IBOutlet var playImageView: UIImageView!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var videoImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
