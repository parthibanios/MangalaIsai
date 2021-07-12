//
//  YoutubeVideoHeaderCell.swift
//  MangalaIsai
//
//  Created by PARTHIBAN on 02/02/20.
//  Copyright © 2020 PARTHIBAN. All rights reserved.
//

import UIKit

class YoutubeVideoHeaderCell: UITableViewCell {

    @IBOutlet var tableViewHeaderHeightConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        tableViewHeaderHeightConstraint.constant  =  UIScreen.main.bounds.height > UIScreen.main.bounds.width ?  UIScreen.main.bounds.height * 0.28 :  UIScreen.main.bounds.width * 0.28
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
