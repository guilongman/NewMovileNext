//
//  ShowOverviewViewController.swift
//  MovileNext
//
//  Created by User on 27/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

class ShowOverviewViewController: UIViewController , ShowInternalViewController {

    @IBOutlet weak var lblOverview: UILabel!
    
    var overview : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblOverview.text = overview
        lblOverview.sizeToFit()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func intrinsicContentSize() -> CGSize{
        let height = 47 + lblOverview.intrinsicContentSize().height
        
        return CGSize(width: lblOverview.intrinsicContentSize().width, height: height)
    }
    
    

}
