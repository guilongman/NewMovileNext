//
//  ShowInfoViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class ShowInfoViewController: UIViewController {
    
    let traktClient = TraktHTTPClient()
    var show : Show!
    var seasons : [Season]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = show!.title
        
        //obtem todas as temporadas do show
        traktClient.getSeasons(show.identifiers.slug!){ result in
            if let seasons = result.value{
                self.seasons = seasons
            }
            else{
                println(result.error)
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == Segue.show_overview{
            let vc = segue.destinationViewController as! ShowOverviewViewController
            vc.overview = show!.overview
        }
        else if segue == Segue.show_seasons{
            let vc = segue.destinationViewController as! SeasonsTableViewController
            vc.seasons = self.seasons
        }
    }

}
