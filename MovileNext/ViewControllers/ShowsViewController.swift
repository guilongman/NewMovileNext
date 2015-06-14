//
//  ShowsViewController.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class ShowsViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var showCollection: UICollectionView!
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    
    let allShows = [ ["GoT": "x"] , ["American Horor History" : "y"], ["GoT": "x"] , ["American Horor History" : "y"], ["GoT": "x"] , ["American Horor History" : "y"], ["GoT": "x"] , ["American Horor History" : "y"], ["GoT": "x"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //defini a quantidade de elementos que terão na tela
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    //defini a exibição (itera) esses elementos na tela
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let identifier = Reusable.ShowCell.identifier!
        
        let cell = showCollection.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! ShowsCollectionViewCell
        
        let show = allShows[indexPath.row]
        
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
    
    

}
