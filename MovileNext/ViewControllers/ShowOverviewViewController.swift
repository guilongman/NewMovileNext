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
        // Do any additional setup after loading the view.
    }
    
    func loadOverview(overview: String){
        lblOverview.text = overview
        lblOverview.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func intrinsicContentSize() -> CGSize{
        
        // altura da label do titulo + label dinamica + borda
        let height = lblOverview.frame.minY + lblOverview.intrinsicContentSize().height + (self.view.frame.height - (lblOverview.frame.minY + lblOverview.frame.height))
        
        return CGSize(width: lblOverview.intrinsicContentSize().width, height: height)
    }
    
    

}
