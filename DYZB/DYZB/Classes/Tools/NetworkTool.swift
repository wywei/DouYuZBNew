//
//  NetworkTool.swift
//  DYZB
//
//  Created by Andy on 2022/9/9.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}

struct NetworkTool {
    
    static func requestData(type: MethodType, URLString: String, parameters:[String: String]?  = nil, finishedCallback:@escaping (_ result: Any) -> Void) {
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        AF.request(URLString, method: method, parameters: parameters).responseJSON { response in
            guard let result = response.value else {
                return
            }
            finishedCallback(result)
        }
          
    }

}
