//
//  AnchorGroup.swift
//  DYZB
//
//  Created by Andy on 2022/9/9.
//

import UIKit

class AnchorGroup: NSObject {
    
    var room_list: [[String: AnyObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                self.anchors.append(AnchorModel(dict: dict))
            }
        }
    }
    
    var tag_name: String = ""
    
    var icon_name: String = ""
    
    lazy var anchors: [AnchorModel] = [AnchorModel]()
    
    init(dict: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override init() {
        
    }
    override class func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    /*
    override class func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            if let dataArray = value as? [[String: AnyObject]]  {
                for dict in dataArray {
                    self.anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }*/
    
}
