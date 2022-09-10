//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by Andy on 2022/9/9.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else {
                return
            }
        }

    }
    
}
