//
//  ShowsCollectionViewCell.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import Haneke

class ShowsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showImage: UIImageView!
    
    @IBOutlet weak var showTitle: UILabel!
    
    func loadShow(show: Show) {

//        for (text, image) in show {
//            showTitle.text = text
//        }
        
        let placeholder = UIImage(named: "poster")
        if let image = show.poster?.thumbImageURL{
            showImage.hnk_setImageFromURL(image, placeholder: placeholder)
        }
        else
        {
            showImage.image = placeholder
        }
        
        showTitle.text = show.title
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        showImage.hnk_cancelSetImage()
        showImage.image = nil
    }
    
}
