//
//  SeasonViewController.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TraktModels
import Spring
import FloatRatingView

/*

    Não esquecer de fazer a "ligação" de datasource e delegate entre o storyboard e o codigo

    ****** CLICAR E ARRASTAR -> IRÁ APARECER A OPÇÃO DE DELEGATE E DATASOURCE *************

*/

//utiliza os protocolos UITableViewDataSource e UITableViewDelegate
class SeasonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableSeason: UITableView!
    
    @IBOutlet weak var seasonImage: UIImageView!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var seasonRating: FloatRatingView!
    @IBOutlet weak var labelRating: UILabel!
    
    //var items: [String] = ["Ep1", "Ep2", "Ep3", "Ep4", "Ep5", "Ep6"]
    
    var episodes : [Episode] = []
    var show : String!
    var season : Season!
    let traktClient = TraktHTTPClient()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.showLoading()
        
        self.title = "Season \(season.number)"
        
        loadEpisodes(show, season: season)
        
        loadSeasonInfo(self.season)
        
        // Do any additional setup after loading the view.
    }
    
    func loadSeasonInfo (season: Season){
        let placeholderSeason = UIImage(named: "bg")
        let placeholderShow = UIImage(named: "poster")
        
        if let imageSeason = season.thumbImageURL{
            seasonImage.kf_setImageWithURL(imageSeason, placeholderImage: placeholderSeason)
        }
        else{
            seasonImage.image = placeholderSeason
        }
        
        if let imageShow = season.poster?.fullImageURL{
            showImage.kf_setImageWithURL(imageShow, placeholderImage: placeholderSeason)
        }
        else{
            showImage.image = placeholderShow
        }
        
        seasonRating.rating = season.rating!
        labelRating.text = String(format: "%.1f", season.rating!)
        
    }
    
    func loadEpisodes (showId: String, season: Season)
    {
        traktClient.getEpisodes(showId, season: season.number){ [weak self] result in
            if let episodes = result.value{
                self?.episodes = episodes
                self?.tableSeason.reloadData()
                self?.view.hideLoading()
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
        cell.loadEpisode(episode)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableSeason.deselectRowAtIndexPath(indexPath, animated: true)
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
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == Segue.season_to_episode.identifier{
            if let cell = sender as? UITableViewCell,
                let indexPath = tableSeason.indexPathForCell(cell){
                    if episodes[indexPath.row].overview == nil{
                        
                        let alert = UIAlertView()
                        alert.title = "Episódio Indisponível"
                        alert.addButtonWithTitle("Ok")
                        alert.show()
                        
                        return false
                    }
            }
        }
        
        return true
        
    }
    
    deinit{
        println("\(self.dynamicType) deinit")
    }
}
