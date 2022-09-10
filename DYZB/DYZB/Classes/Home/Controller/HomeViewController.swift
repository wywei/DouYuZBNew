//
//  HomeViewController.swift
//  DYZB
//
//  Created by Andy on 2022/9/7.
//

import UIKit

private let kTitleViewH: CGFloat = 40
class HomeViewController: UIViewController {
    
    private lazy var pageTitleView: PageTitleView = { 
        let frame = CGRect(x: 0, y: kNavigationBarH + kStatusBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titlePageView = PageTitleView(frame: frame, titles: titles)
        titlePageView.delegate = self
        return titlePageView
    }()

    private lazy var pageContentView: PageContentView = { [weak self] in
        
        let contentViewH: CGFloat = kScreenH - kNavigationBarH - kStatusBarH - kTitleViewH - kTabbarH
        let frame = CGRect.init(x: 0, y: kNavigationBarH + kStatusBarH + kTitleViewH , width: kScreenW, height: contentViewH)
        var childVcs = [UIViewController]()
        childVcs.append(RecomendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let pageContentView = PageContentView(frame: frame, childVcs: childVcs, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
    }()
     
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        NetworkTool.requestData(type: .GET, URLString: "http://httpbin.org/get") { response in
            print(response)
        }
        
    }

}


// MARK: - 设置UI界面
extension HomeViewController {
    
    private func setupUI() {
      
        // 1.设置导航条
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
        
    }
    
    // 1.设置导航条
    private func setupNavigationBar() {
        
        // 1.设置左边的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "reader_slider_icon")
        
        // 2.设置右边的items
        let size = CGSize.init(width: 40, height: 40)
        let rightItem1 = UIBarButtonItem(imageName: "reader_slider_icon", highImageName: "reader_slider_icon", size: size)
        let rightItem2 = UIBarButtonItem(imageName: "reader_slider_icon", highImageName: "reader_slider_icon", size: size)
        let rightItem3 = UIBarButtonItem(imageName: "reader_slider_icon", highImageName: "reader_slider_icon", size: size)
        navigationItem.rightBarButtonItems = [rightItem1, rightItem2, rightItem3]
    }
    
}


extension HomeViewController: PageTitleViewDelegate {
    
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
    
}


extension HomeViewController: PageContentViewDelegate {
    
    func pageContentView(pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitle(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}
