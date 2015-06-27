//
//  SeasonsTableViewCell.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher
import FloatRatingView

class SeasonsTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSeasonNumber: UILabel!
    @IBOutlet weak var lblNumEpisodes: UILabel!
    @IBOutlet weak var imgSeason: UIImageView!
    @IBOutlet weak var seasonRating: FloatRatingView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadSeasons (season: Season)
    {
        let seasonNumber = (season.number == 0 ? "Especial" : "Season \(season.number)")
        
        lblSeasonNumber.text = seasonNumber
        lblNumEpisodes.text = "\(season.episodeCount!) Episodes"
            
        let placeholder = UIImage(named: "poster")
        if let image = season.poster?.fullImageURL{
            imgSeason.kf_setImageWithURL(image, placeholderImage: placeholder)
        }
        else
        {
            imgSeason.image = placeholder
        }
        
        seasonRating.rating = season.rating!
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
