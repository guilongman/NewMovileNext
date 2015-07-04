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

    @IBOutlet weak var favoritesSegControl: UISegmentedControl!
    
    @IBOutlet weak var showCollection: UICollectionView!
    
    let traktClient = TraktHTTPClient()
    
    let refreshControl = UIRefreshControl()
    
    //quando se declara uma variável com ?, indica que ela poderá ser usada ou não na aplicação
    var shows : [Show]? = []
    
    //let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shows"
        self.navigationController?.navigationBar.hideBottomHairline()
        
        loadPopularShows()
        
        registraNotificacao()
        
        refreshControl.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        
        self.showCollection.addSubview(refreshControl)
        self.showCollection.alwaysBounceVertical = true
    }
    
    func refresh ()
    {
        loadShows()
        refreshControl.endRefreshing()
    }

    func registraNotificacao()
    {
        let name = FavoritesManager.favoritesChangedNotificationName
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "loadShows", name: name, object: nil)
    }  
    
    func loadPopularShows ()
    {
        view.showLoading()
        traktClient.getPopularShows{ [weak self] popular in
            if let values = popular.value {
                self?.shows = values
                self?.showCollection.reloadData()
                self?.view.hideLoading()
            }
            else{
                //ou talvez colocar num log de erro
                println("Erro: \(popular.error)")
                self?.view.hideLoading()
                
            }
        }
    }
    
    func loadFavoritesShows(favoritesShows: Set<Int>)
    {
        view.showLoading()
        
        var newShows : [Show] = []
        
        self.shows?.filter{ favoritesShows.contains($0.identifiers.trakt) }.map{ newShows.append($0) }
       
        self.shows = newShows
        self.showCollection.reloadData()
        
        self.view.hideLoading()
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
    
    @IBAction func segmentChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.loadPopularShows()
        }
        else if sender.selectedSegmentIndex == 1{
            loadFavoritesShows(FavoritesManager().favoritesIdentifiers)
        }
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemSize = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing
        let maxPerRow = floor((collectionView.bounds.width) / itemSize) - floor((collectionView.bounds.width) / itemSize) + 3
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
    
    func loadShows()
    {
        segmentChanged(self.favoritesSegControl)
    }
    
    deinit {
        let name = FavoritesManager.favoritesChangedNotificationName
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.removeObserver(self, name: name, object: nil)
    }

}