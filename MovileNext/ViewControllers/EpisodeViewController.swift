//
//  EpisodeViewController.swift
//  MovileNext
//
//  Created by User on 13/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import Kingfisher

class EpisodeViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descTextView: UITextView!
    
    let traktClient = TraktHTTPClient()
    
    //quando precisar declarar um variável que irá ser usada, pode-se colocar "!" fazendo um unwrap forçado
    var episode : Episode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descTextView.textContainer.lineFragmentPadding = 0
        descTextView.textContainerInset = UIEdgeInsetsZero
        
        loadEpisode(episode!)
    }
    
    func loadEpisode(episode: Episode)
    {
        let placeholder = UIImage(named: "bg")
        
        if var image = episode.screenshot?.fullImageURL{
            self.coverImageView.kf_setImageWithURL(image, placeholderImage: placeholder)
            //self.coverImageView.hnk_setImageFromURL(image, placeholder: placeholder)
            self.coverImageView.image = self.coverImageView.image?.darkenImage()
        }
        else
        {
            self.coverImageView.image = placeholder
        }
        
        self.titleLabel.text = episode.title
        self.descTextView.text = episode.overview
    }
    
    @IBAction func sharePressed(sender: UIBarButtonItem) {
        
        let url = NSURL(string: "http://www.apple.com")!
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        presentViewController(vc, animated: true, completion: nil)
        //println("pressed")
    }

}
