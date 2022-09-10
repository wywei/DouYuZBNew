//
//  CollectionNormalCell.swift
//  DYZB
//
//  Created by Andy on 2022/9/9.
//

import UIKit
import Kingfisher
class CollectionNormalCell: CollectionBaseCell {

    
   override var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
            super.anchor = anchor
            
        }

    }
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
