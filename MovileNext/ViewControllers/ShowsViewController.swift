//
//  ShowsViewController.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import Result
import TraktModels

class ShowsViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var showCollection: UICollectionView!

    let traktClient = TraktHTTPClient()
    
    //quando se declara uma variável com ?, indica que ela poderá ser usada ou não na aplicação
    var shows : [Show]? = []
    
    //let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shows"
        
        loadPopularShows()
        
        //códigos de teste --> JSON
//        traktClient.getShow("game-of-thrones") //{ _ in }
//        traktClient.getEpisode("game-of-thrones", season: 5, episodeNumber: 10)
//        traktClient.getPopularShows(){ [weak self] x in
//            for a in x.value!
//            {
//                println(a.title)
//            }
//        }
//        
//        traktClient.getSeasons("game-of-thrones"){ x in
//            for a in x.value!
//            {
//                println(a.number)
//                println(a.episodeCount)
//            }
//        }
//        
//        traktClient.getEpisodes("game-of-thrones", season: 0){
//            x in
//            for a in x.value!
//            {
//                println(a.title)
//            }
//        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadPopularShows ()
    {
        traktClient.getPopularShows{ [weak self] popular in
            if let values = popular.value {
                self?.shows = values
                self?.showCollection.reloadData()
            }
            else{
                //ou talvez colocar num log de erro
                println("Erro: \(popular.error)")
            }
        }
    }
    
    //defini a quantidade de elementos que terão na tela
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.shows!.count
    }
    
    //defini a exibição (itera) esses elementos na tela
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = Reusable.ShowCell.identifier!
        
        let cell = showCollection.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ShowsCollectionViewCell
        
        let show = shows![indexPath.row]
        
        cell.loadShow(show)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let itemSize = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let maxPerRow = floor((collectionView.bounds.width) / itemSize)
        let usedSpace = itemSize * maxPerRow
        
        let additionalSpace = flowLayout.minimumInteritemSpacing * maxPerRow
        
        let sideSpace = floor(((collectionView.bounds.width - usedSpace) + additionalSpace) / (maxPerRow + 1))
        
        
        
        let space = floor((collectionView.bounds.width - usedSpace) / 4)
        
        return UIEdgeInsets(top: flowLayout.sectionInset.top, left: sideSpace, bottom: flowLayout.sectionInset.bottom, right: sideSpace)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue == Segue.show_details{
            if let cell = sender as? UICollectionViewCell,
                let indexPath = showCollection.indexPathForCell(cell)
            {
                let vc = segue.destinationViewController as! ShowInfoViewController
                vc.show = shows![indexPath.row]
            }
        }
    }
    

}



































