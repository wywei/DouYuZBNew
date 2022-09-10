//
//  AnchorModel.swift
//  DYZB
//
//  Created by Andy on 2022/9/9.
//

import UIKit

class AnchorModel: NSObject {
    
    var room_id: Int = 0
    var vertical_src: String = ""
    var isVertical: Int = 0
    var room_name: String = ""
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override class func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
}
