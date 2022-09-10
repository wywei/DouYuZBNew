//
//  CollectionPrettyCell.swift
//  DYZB
//
//  Created by Andy on 2022/9/9.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet weak var addressLabel: UIButton!
    
    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
