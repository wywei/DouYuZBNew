//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by Andy on 2022/9/9.
//

import UIKit

class RecommendViewModel {
    lazy var anchorgroup: [AnchorGroup] = [AnchorGroup]()
    private lazy var bigGroup: AnchorGroup = AnchorGroup()
    private lazy var prettyGroup: AnchorGroup = AnchorGroup()
}

extension RecommendViewModel {
    
    func loadData(finishCallback: @escaping () -> (Void)) {
        
        let dis_group = DispatchGroup()
        
        // 第一部分
        dis_group.enter()
        NetworkTool.requestData(type: .GET, URLString: "http://httpbin.org/get") { result in
            guard let resultDict = result as? [String: AnyObject] else { return }
            guard let dataArr = resultDict["data"] as? [[String: AnyObject]] else { return }
            self.bigGroup.tag_name = "热门"
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                self.bigGroup.anchors.append(anchor)
            }
            dis_group.leave()
        }
        
        // 第二部分
        dis_group.enter()
        NetworkTool.requestData(type: .GET, URLString: "http://httpbin.org/get") { result in
            guard let resultDict = result as? [String: AnyObject] else { return }
            guard let dataArr = resultDict["data"] as? [[String: AnyObject]] else { return }
            self.prettyGroup.tag_name = "颜值"
            for dict in dataArr {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            dis_group.leave()
        }
        
        // 第三部分
        dis_group.enter()
        NetworkTool.requestData(type: .GET, URLString: "http://httpbin.org/get", parameters: ["time":Date.getCurrentTime()]) { result in
            guard let resultDict = result as? [String: AnyObject] else { return }
            guard let dataArr = resultDict["data"] as? [[String: AnyObject]] else { return }
            for dict in dataArr {
                let group = AnchorGroup(dict: dict)
                self.anchorgroup.append(group)
            }
            dis_group.leave()
        }
        
        dis_group.notify(queue: DispatchQueue.main) {
            print("所有数据都请求到")
            self.anchorgroup.insert(self.prettyGroup, at: 0)
            self.anchorgroup.insert(self.bigGroup, at: 0)
            finishCallback()
        }
        
        
    }
}
