//
//  FavoritesManager.swift
//  MovileNext
//
//  Created by User on 28/06/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import UIKit
import Foundation

class FavoritesManager {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var favoritesIdentifiers: Set<Int> = []
    
    func read() -> Set<Int>
    {
        var letters = Set<Character>()
        var identifiers : Set<Int>()
        identifiers.insert(1)
        
        if let values = defaults.arrayForKey("shows") as? [Int]{
            for value in values{
                //identifiers.insert(value)
            }
        }
        return identifiers
    }
    
    func addIdentifier(identifier: Int){
        
    }
}
