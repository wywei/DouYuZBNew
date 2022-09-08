//
//  UIBarButtonItem+Extension.swift
//  DYZB
//
//  Created by Andy on 2022/9/7.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize(width: 40, height: 40)) {
        // 1.创建UIButton
        let btn = UIButton()
        // 2.设置图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        // 3.设置大小
        if size == CGSize.zero {
            btn.sizeToFit()
        } else {
            btn.frame = CGRect(origin:.zero, size: size)
        }
        self.init(customView: btn)
    }
    
}
