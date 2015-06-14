//
//  EpisodeTableViewCell.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

// SETAR O STYLE NO STORYBOARD O STYLE, APONTANDO PARA A ESSA CLASSE

class EpisodeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.textColor = UIColor.grayColor()
        textLabel?.font = UIFont.systemFontOfSize(15)
        
        detailTextLabel?.textColor = UIColor.mup_textColor()
        detailTextLabel?.font = UIFont.systemFontOfSize(18)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
