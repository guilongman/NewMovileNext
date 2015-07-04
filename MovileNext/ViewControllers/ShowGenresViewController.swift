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
    
    var genres : [String]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func loadGenres(genres: [String])
    {
        tagListGenres.textFont = UIFont.systemFontOfSize(12)
        genres.map(tagListGenres.addTag)
    }
    
    func intrinsicContentSize() -> CGSize {
        let distanciaAteList = tagListGenres.frame.minY
        let tamanhoList = tagListGenres.frame.size.height
        let tamanhoBordaBaixo = self.view.frame.size.height - (distanciaAteList + tamanhoList)
        let height = distanciaAteList + tagListGenres.intrinsicContentSize().height + tamanhoBordaBaixo
        return CGSize(width: tagListGenres.intrinsicContentSize().width, height: height)
    }

}
