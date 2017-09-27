//
//  FMStringRange.swift
//  FMPather
//
//  Created by Fantasy on 2017/9/16.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import Foundation

extension String {
    func nsRange(range index: Range<String.Index>) -> NSRange {
        let from = index.lowerBound.samePosition(in: utf16)
        let to = index.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex,
                                                to: from),
                       length: utf16.distance(from: from,
                                              to: to))
    }
    
    func range(index range: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex,
                                     offsetBy: range.location,
                                     limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16,
                                   offsetBy: range.length,
                                   limitedBy: utf16.endIndex),
            let from = String.Index(from16,
                                    within: self),
            let to = String.Index(to16,
                                  within: self)
        else {
                return nil
        }
        return from ..< to
        
        
    }
}
