//
//  Date-Extension.swift
//  DYZB
//
//  Created by Andy on 2022/9/9.
//

import UIKit

extension Date {
    
    static func getCurrentTime() -> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
    
}

