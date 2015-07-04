//
//  NSDate+Comparing.swift
//  MovileNext
//
//  Created by User on 04/07/15.
//  Copyright (c) 2015 Movile. All rights reserved.
//

import Foundation
import UIKit

extension NSDate{
    func isGreater(toCompare: NSDate) -> Bool{
        return self.compare(toCompare) == NSComparisonResult.OrderedDescending
    }
    
    func isLess(toCompare: NSDate) -> Bool{
        return self.compare(toCompare) == NSComparisonResult.OrderedAscending
    }
    
    func isEquals(toCompare: NSDate) -> Bool {
        return self.compare(toCompare) == NSComparisonResult.OrderedSame
    }
}
