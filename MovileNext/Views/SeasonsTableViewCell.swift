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
    @IBOutlet weak var lblRatingNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        layoutMargins = UIEdgeInsetsZero
        preservesSuperviewLayoutMargins = false
    }
    
    func loadSeasons (season: Season)
    {
        let seasonNumber = (season.number == 0 ? "Special" : "Season \(season.number)")
        
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
        lblRatingNumber.text = String(format: "%.1f", season.rating!)        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgSeason.image = nil
        lblNumEpisodes.text = ""
        lblSeasonNumber.text = ""
        seasonRating.rating = 0
    }

}
