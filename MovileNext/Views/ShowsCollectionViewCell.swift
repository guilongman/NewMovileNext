//
//  ShowsCollectionViewCell.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher

class ShowsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showImage: UIImageView!
    
    @IBOutlet weak var showTitle: UILabel!
    
    var task : RetrieveImageTask?
    
    func loadShow(show: Show) {

//        for (text, image) in show {
//            showTitle.text = text
//        }
        
        let placeholder = UIImage(named: "poster")
        if let image = show.poster?.thumbImageURL{
            self.task = showImage.kf_setImageWithURL(image, placeholderImage: placeholder)
        }
        else
        {
            showImage.image = placeholder
        }
        
        showTitle.text = show.title
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        showImage.image = nil
        self.task?.cancel()
    }
    
}
