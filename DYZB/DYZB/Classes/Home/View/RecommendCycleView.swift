//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by Andy on 2022/9/11.
//

import UIKit

class RecommendCycleView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = []
    }
    
    
    
}


extension RecommendCycleView {
    static func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}
