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
    
    static let favoritesChangedNotificationName = "FavoritesChanged"
    static let key = "shows"
    
    var favoritesIdentifiers: Set<Int> = {
        let defaults = NSUserDefaults.standardUserDefaults()
        var aux = Set<Int>()
        
        if let favorites = defaults.arrayForKey(key) as? [Int]{
            favorites.map{aux.insert($0)}
        }
        return aux
    }()
    
    func addIdentifier(identifier: Int){
        let defaults = NSUserDefaults.standardUserDefaults()
        self.favoritesIdentifiers.insert(identifier)
        defaults.setObject(Array(self.favoritesIdentifiers), forKey: self.dynamicType.key)
        defaults.synchronize()
        postarNotificao()
    }
    
    func removeIdentifier(identifier: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        self.favoritesIdentifiers.remove(identifier)
        defaults.removeObjectForKey(self.dynamicType.key)
        defaults.setObject(Array(self.favoritesIdentifiers), forKey: self.dynamicType.key)
        defaults.synchronize()
        postarNotificao()
    }
    
    func contains(identifier: Int) -> Bool{
        return self.favoritesIdentifiers.contains(identifier)
    }
    
    func postarNotificao ()
    {
        let name = self.dynamicType.favoritesChangedNotificationName
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.postNotificationName(name, object: self)
    }

}
