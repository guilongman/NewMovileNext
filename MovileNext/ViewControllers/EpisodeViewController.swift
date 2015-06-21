//
//  EpisodeViewController.swift
//  MovileNext
//
//  Created by User on 13/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

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
        
        //teste
        loadEpisode(episode!)
        //coverImageView.image = UIImage(named: "bg")
    }
    
    func loadEpisode(episode: Episode)
    {
        let placeholder = UIImage(named: "bg")
        
        if let image = episode.screenshot?.fullImageURL{
            self.coverImageView.hnk_setImageFromURL(image, placeholder: placeholder)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
