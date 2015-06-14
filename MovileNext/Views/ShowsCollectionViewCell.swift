//
//  ShowsCollectionViewCell.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class ShowsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showImage: UIImageView!
    
    @IBOutlet weak var showTitle: UILabel!
    
    func loadShow(show: [String:String]) {

        for (text, image) in show {
            showTitle.text = text
        }
        
    }
    
    
}
