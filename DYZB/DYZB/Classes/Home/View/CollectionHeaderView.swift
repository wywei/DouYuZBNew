//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by Andy on 2022/9/9.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    var group: AnchorGroup? {
        didSet {
            guard let group = group else {
                return
            }
            titleLabel.text = group.tag_name
            iconImageView.image = UIImage(named: group.icon_name)
        }
    }
    
}
