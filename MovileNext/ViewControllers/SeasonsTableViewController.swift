//
//  SeasonsTableViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

protocol SeasonsTableViewControllerDelegate: class{
    func seasonsController(vc: SeasonsTableViewController, didSelectSeason season: Season)
}

class SeasonsTableViewController: UITableViewController, ShowInternalViewController {

    var seasons : [Season]!
    
    weak var delegate : SeasonsTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadSeasons(self.seasons)
        //tableView.reloadData()
    }
    
    func loadSeasons(seasons: [Season]?)
    {
        self.seasons = seasons
        tableView.reloadData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.seasons?.count ?? 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.SeasonCell.identifier!
        
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! SeasonsTableViewCell
        
        let index = seasons.count - (indexPath.row + 1)

        cell.loadSeasons(seasons![index])
        
        return cell
    }
    
    func intrinsicContentSize() -> CGSize {
        return tableView.contentSize
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let season = seasons[seasons.count - (indexPath.row + 1)]
        delegate?.seasonsController(self, didSelectSeason: season)
    }

}
