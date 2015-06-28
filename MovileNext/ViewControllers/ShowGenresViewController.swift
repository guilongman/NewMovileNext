//
//  ShowGenresViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TagListView

class ShowGenresViewController: UIViewController, ShowInternalViewController {

    @IBOutlet weak var tagListGenres: TagListView!
    
    var genres : [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGenres()
        // Do any additional setup after loading the view.
    }
    
    func loadGenres()
    {
        tagListGenres.textFont = UIFont.systemFontOfSize(12)
        self.genres?.map(tagListGenres.addTag)
        
//        for genre in self.genres!{
//            tagListGenres.addTag(genre)
//        }
    }
    
    func intrinsicContentSize() -> CGSize {
        println(self.view.frame.minY)
        println(self.view.frame.maxY)
        println(self.view.frame.size.height)
        println(tagListGenres.frame.size.height)
        println(tagListGenres.frame.minY)
        println(tagListGenres.frame.maxY)
        
        let distanciaAteList = tagListGenres.frame.minY
        let tamanhoList = tagListGenres.frame.size.height
        let tamanhoBordaBaixo = self.view.frame.size.height - (distanciaAteList + tamanhoList)
        let height = distanciaAteList + tagListGenres.intrinsicContentSize().height + tamanhoBordaBaixo
        
//        println(distanciaAteList)
//        println(tamanhoList)
//        println(tamanhoBordaBaixo)
//        println(x + 1000)
        
//        let distanciaAteList = tagListGenres.frame.minY - self.view.frame.minY
//        let tamanhoList = tagListGenres.intrinsicContentSize().height
//        let tamanhoBordaBaixo = self.view.frame.size.height - distanciaAteList + tamanhoList
//        
//        let height = distanciaAteList + tamanhoList + tamanhoBordaBaixo
        
        //let height = tagListGenres.intrinsicContentSize().height + 47
        println(height)
        println(tamanhoBordaBaixo)
        return CGSize(width: tagListGenres.intrinsicContentSize().width, height: height)
    }

}
