//
//  SeasonViewController.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels

/*

    Não esquecer de fazer a "ligação" de datasource e delegate entre o storyboard e o codigo

    ****** CLICAR E ARRASTAR -> IRÁ APARECER A OPÇÃO DE DELEGATE E DATASOURCE *************

*/

//utiliza os protocolos UITableViewDataSource e UITableViewDelegate
class SeasonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableSeason: UITableView!
    
    //var items: [String] = ["Ep1", "Ep2", "Ep3", "Ep4", "Ep5", "Ep6"]
    
    var episodes : [Episode] = []
    var show = String()
    var season = Int()
    let traktClient = TraktHTTPClient()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.season = 1
        
        loadEpisodes(show, season: season)
        
        // Do any additional setup after loading the view.
    }
    
    func loadEpisodes (showId: String, season: Int)
    {
        traktClient.getEpisodes(showId, season: season){ [weak self] result in
            if let episodes = result.value{
                self?.episodes = episodes
                self?.tableSeason.reloadData()
            }
            else
            {
                println("Erro: \(result.error)")
            }
        }
    }
    
    //número de linhas na table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    //percorre todas a quantidade de células definidas em tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int e podem ser populadas a partir desse método
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.EpisodeCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! EpisodeTableViewCell
        
        let episode = episodes[indexPath.row]
        
        
//        let epSeason = {x
//            if count(String(episode.seasonNumber)) = 1{
//                return "0" + String(episode.seasonNumber)
//            }
//            else{
//             return String(episode.seasonNumber)
//            }
//        }
        
        
        cell.textLabel!.text = "S\(episode.seasonNumber)E\(episode.number)"
        cell.detailTextLabel?.text = episode.title
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == Segue.season_to_episode{
            if let cell = sender as? UITableViewCell,
                let indexPath = tableSeason.indexPathForCell(cell){
                    tableSeason.deselectRowAtIndexPath(indexPath, animated: false)
                    let vc = segue.destinationViewController as! EpisodeViewController
                    vc.episode = episodes[indexPath.row]
            }
        }
    }
}
