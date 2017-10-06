//
//  FMPatherPathData.swift
//  FMPather
//
//  Created by Fantasy on 2017/9/21.
//  Copyright © 2017年 fantasy. All rights reserved.
//

import UIKit

public protocol FMPatherPathData: class {
    var querys: [String: String] {set get}
    var dynamicNode: [String: String] {set get}
    var url: String {set get}
}

