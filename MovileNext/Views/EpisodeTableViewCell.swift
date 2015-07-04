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
        textLabel?.font = UIFont(name: "HelveticaNeue", size: 15)
        
        detailTextLabel?.textColor = UIColor.mup_textColor()
        detailTextLabel?.font = UIFont(name: "HelveticaNeue", size: 18)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func loadEpisode (episode: Episode)
    {
        textLabel!.text = "S\(episode.seasonNumber)E\(episode.number)"
        
        if episode.firstAired != nil {
            if episode.firstAired!.isGreater(NSDate()){
                detailTextLabel?.textColor = UIColor.grayColor()
            }
            else {
                detailTextLabel?.textColor = UIColor.mup_textColor()
            }
        }
        
        if episode.overview != nil {
            if episode.title != nil{
                detailTextLabel?.text = episode.title
            }
            else {
                detailTextLabel?.text = "Episódio indisponível"
                detailTextLabel?.textColor = UIColor.grayColor()
            }
        }
        else {
            detailTextLabel?.text = "Episódio indisponível"
            detailTextLabel?.textColor = UIColor.grayColor()
        }
        
    }

}
