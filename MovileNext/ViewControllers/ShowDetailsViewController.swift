//
//  ShowDetailsViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

class ShowDetailsViewController: UIViewController {

    @IBOutlet weak var lblNetwork: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblAiredEp: UILabel!
    @IBOutlet weak var lblStartedIn: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    
    var show : Show!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func loadDetails(show: Show)
    {
        
        lblNetwork.text = show.network
        lblStatus.text = show.status?.rawValue.capitalizedString
        lblAiredEp.text = String(show.airedEpisodes!)
        lblStartedIn.text = String(show.year)
        lblCountry.text = show.country?.uppercaseString
        
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
