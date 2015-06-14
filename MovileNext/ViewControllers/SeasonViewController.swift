//
//  SeasonViewController.swift
//  MovileNext
//
//  Created by User on 14/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit

/*

    Não esquecer de fazer a "ligação" de datasource e delegate entre o storyboard e o codigo

    ****** CLICAR E ARRASTAR -> IRÁ APARECER A OPÇÃO DE DELEGATE E DATASOURCE *************

*/


//utiliza os protocolos UITableViewDataSource e UITableViewDelegate
class SeasonViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableSeason: UITableView!
    
    var items: [String] = ["Ep1", "Ep2", "Ep3", "Ep4", "Ep5", "Ep6"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //número de linhas na table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    //percorre todas a quantidade de células definidas em tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int e podem ser populadas a partir desse método
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier = Reusable.EpisodeCell.identifier!
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel!.text = "S01E\(indexPath.row)"
        cell.detailTextLabel?.text = "Episode \(indexPath.row)"
        
        return cell
    }
}
