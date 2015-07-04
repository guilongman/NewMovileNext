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
import Spring

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
    @IBOutlet weak var btnLike: UIButton!
    
    
    var showLoaded : Bool = false
    var seasonsLoaded : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.showLoading()
        self.title = show!.title
        
        loadShow()
    }
    
    func loadShow ()
    {
        traktClient.getShow(show.identifiers.slug!){ [weak self] result in
            if let fullShow = result.value{
                self?.show = fullShow
                
                self?.loadShowInfo(fullShow)
                self?.detailsViewController.loadDetails(fullShow)
                self?.overviewViewController.loadOverview(fullShow.overview!)
                self?.genresViewController.loadGenres(fullShow.genres!)
                
                self?.showLoaded = true
                self?.isLoaded(self!.showLoaded, seasons: self!.seasonsLoaded)
            }
            else{
                println(result.error)
            }
        }
        
        //obtem todas as temporadas do show
        traktClient.getSeasons(show.identifiers.slug!){ [weak self] result in
            if let seasons = result.value{
                self?.seasons = seasons
                self?.seasonsViewController.loadSeasons(seasons)
                self?.seasonsLoaded = true
                self?.isLoaded(self!.showLoaded, seasons: self!.seasonsLoaded)
            }
            else{
                println(result.error)
            }
        }

    }
    
    func isLoaded (show: Bool, seasons: Bool)
    {
        if show == true && seasons == true
        {
            view.hideLoading()
        }
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
        if FavoritesManager().contains(show.identifiers.trakt){
            btnLike.selected = true
            //btnLike.imageView?.image = UIImage(named: "like-heart-on")
        }
    }
    
    @IBAction func doFavoriteShow(sender: UIButton) {
        let favoriteM = FavoritesManager()
        let identifier = show.identifiers.trakt
        
        if favoriteM.contains(identifier){
            favoriteM.removeIdentifier(identifier)
            btnLike.selected = false
            
            //btnLike.setImage(UIImage(named: "like-heart"), forState: .Normal)
        }
        else{
            favoriteM.addIdentifier(identifier)
            btnLike.selected = true
            //btnLike.setImage(UIImage(named: "like-heart-on"), forState: .Normal)
        }
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
