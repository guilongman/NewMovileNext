//
//  ShowOverviewViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class ShowOverviewViewController: UIViewController {

    @IBOutlet weak var textOverview: UITextView!
    
    var overview : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textOverview.text = overview
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
