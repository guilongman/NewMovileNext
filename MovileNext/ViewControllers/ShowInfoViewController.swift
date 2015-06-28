//
//  ShowInfoViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import FloatRatingView
import Kingfisher

class ShowInfoViewController: UIViewController, SeasonsTableViewControllerDelegate {
    
    let traktClient = TraktHTTPClient()
    var show : Show!
    var seasons : [Season]?
    
    var selectedSeason : Season!
    
    private weak var overviewViewController : ShowOverviewViewController!
    private weak var seasonsViewController: SeasonsTableViewController!
    private weak var genresViewController : ShowGenresViewController!
    private weak var detailsViewController : ShowDetailsViewController!
    
    @IBOutlet weak var overviewConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var seasonsConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var genresConstraintHeight: NSLayoutConstraint!
    
    @IBOutlet weak var imgShow: UIImageView!
    @IBOutlet weak var lblShowYear: UILabel!
    @IBOutlet weak var viewFloatRating: FloatRatingView!
    @IBOutlet weak var lblRating: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = show!.title
        
        loadShowInfo(self.show)
        
        //obtem todas as temporadas do show
        traktClient.getSeasons(show.identifiers.slug!){ [weak self] result in
            if let seasons = result.value{
                self?.seasons = seasons
                self?.seasonsViewController.loadSeasons(seasons)
            }
            else{
                println(result.error)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    func loadShowInfo(show: Show)
    {
        let imgPlaceholder = UIImage(named: "bg")
        if let image = show.thumbImageURL{
            imgShow.kf_setImageWithURL(image, placeholderImage: imgPlaceholder)
        }
        else
        {
            imgShow.image = imgPlaceholder
        }
        
        lblShowYear.text = String(show.year)
        viewFloatRating.rating = show.rating!
        lblRating.text = String(format: "%.1f", show.rating!)
        
    }
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        
        overviewConstraintHeight.constant = overviewViewController.intrinsicContentSize().height
        seasonsConstraintHeight.constant = seasonsViewController.intrinsicContentSize().height
        genresConstraintHeight.constant = genresViewController.intrinsicContentSize().height

    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == Segue.show_overview{
            overviewViewController = segue.destinationViewController as! ShowOverviewViewController
            overviewViewController.overview = show!.overview
        }
        else if segue == Segue.show_seasons{
            seasonsViewController = segue.destinationViewController as! SeasonsTableViewController
            seasonsViewController.seasons = self.seasons
            seasonsViewController.delegate = self
        }
        else if segue == Segue.show_genres{
            genresViewController = segue.destinationViewController as! ShowGenresViewController
            genresViewController.genres = show!.genres
        }
        else if segue == Segue.show_details{
            detailsViewController = segue.destinationViewController as! ShowDetailsViewController
            detailsViewController.show = self.show!
        }
        else if segue == Segue.show_to_season{
            let vc = segue.destinationViewController as! SeasonViewController
            vc.show = self.show.identifiers.slug!
            vc.season = self.selectedSeason.number
        }
    }
    
    func seasonsController(vc: SeasonsTableViewController, didSelectSeason season: Season){
        selectedSeason = season
        performSegue(Segue.show_to_season, sender: nil)
    }

}
