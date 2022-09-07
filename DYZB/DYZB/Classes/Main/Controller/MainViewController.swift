//
//  MainViewController.swift
//  DYZB
//
//  Created by Andy on 2022/9/7.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVc("Home")
        addChildVc("Live")
        addChildVc("Follow")
        addChildVc("Profile")
    }
    
    private func addChildVc(_ strongName: String) {
        // 1.从Storyboard获取控制器
        let childVc = UIStoryboard(name: strongName, bundle: nil).instantiateInitialViewController()!
       
        // 2.添加子控制器
        addChild(childVc)
    }


}
