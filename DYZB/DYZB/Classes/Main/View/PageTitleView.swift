//
//  PageTitleView.swift
//  DYZB
//
//  Created by Andy on 2022/9/8.
//

import UIKit



protocol PageTitleViewDelegate: class {
    
    func pageTitleView(titleView: PageTitleView, selectIndex index: Int)
}

private let kNormalColor:(CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor:(CGFloat, CGFloat, CGFloat) = (255, 128, 0)
private let kScrollViewH: CGFloat = 2

class PageTitleView: UIView {
    
    var delegate: PageTitleViewDelegate?
    private var currentIndex: Int = 0
    private var titles: [String] = []
    private lazy var titleLabels:[UILabel] = []
    
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.purple
        return scrollLine
    }()
 
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


extension PageTitleView {
    
    private func setupUI() {
        
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitleLabels()
    
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels() {
        
        let labelW:CGFloat = frame.width/CGFloat(titles.count)
        let labelH:CGFloat = frame.height - kScrollViewH
        let labelY:CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            
            let labelX:CGFloat = CGFloat(index)*labelW
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
           
            
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapLabel(_:)))
            label.addGestureRecognizer(tap)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        let line = UIView()
        line.backgroundColor = UIColor.gray
        let lineH: CGFloat = 0.5
        line.frame = CGRect.init(x: 0, y: frame.height-lineH, width: frame.width, height: lineH)
        scrollView.addSubview(line)
        
        guard let firstLabel = titleLabels.first else { return }
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect.init(x: firstLabel.frame.origin.x, y: frame.height-kScrollViewH, width: firstLabel.frame.width, height: kScrollViewH)
    }
}

extension PageTitleView {
    
    @objc private func tapLabel(_ tap: UITapGestureRecognizer) {
        
        let currentLabel = tap.view
        guard let currentLabel = currentLabel as? UILabel else {
            return
        }
        
        let oldLabel = titleLabels[currentIndex]
        
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentIndex = currentLabel.tag
        
        let scrollLineX: CGFloat = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitleView(titleView: self, selectIndex: currentIndex)
    }
    
}


extension PageTitleView {
    
    func setTitle(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
      
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX

        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        currentIndex = targetIndex
    }
    
}
