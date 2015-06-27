//
//  EpisodeTableViewCell.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

// SETAR O STYLE NO STORYBOARD O STYLE, APONTANDO PARA A ESSA CLASSE

class EpisodeTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel?.textColor = UIColor.grayColor()
        textLabel?.font = UIFont.systemFontOfSize(15)
        
        detailTextLabel?.textColor = UIColor.mup_textColor()
        detailTextLabel?.font = UIFont.systemFontOfSize(18)
    }
    
    func loadEpisode (episode: Episode)
    {
        isAired(episode.firstAired)
        textLabel!.text = "S\(episode.seasonNumber)E\(episode.number)"
        detailTextLabel?.text = episode.title
    }
    
    private func isAired (firstAired: NSDate?)
    {
        if let fAired : NSDate = firstAired {
            if NSDate().compare(fAired) == NSComparisonResult.OrderedDescending{
                textLabel?.textColor = UIColor.grayColor()
                detailTextLabel?.textColor = UIColor.grayColor()
            }
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
