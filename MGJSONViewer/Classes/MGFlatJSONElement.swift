//
//  MGFlatJSONElement.swift
//  Json Viewer
//
//  Created by Moinuddin Girach on 08/15/2022.
//  Copyright (c) 2022 Moinuddin Girach. All rights reserved.
//

import Foundation

class MGFlatJSONElement: CustomStringConvertible {
    
    enum DataType {
        case array
        case object
        case string
        case number
        case bool
    }
    
    var description: String {
        return "\(level) : \(key ?? "") : \(value ?? "")\n"
    }
    var level = 0
    var key: String?
    var value: String?
    var type: DataType = .string
    var child: Any?
    var isExpanded = false
    var childs: Int = 0
}
