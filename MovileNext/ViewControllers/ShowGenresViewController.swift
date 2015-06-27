//
//  ShowGenresViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import TagListView

class ShowGenresViewController: UIViewController {

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

}
