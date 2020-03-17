//
//  AppLimitAPI.swift
//  SwiftStudy
//
//  Created by 王贵彬 on 2020/3/17.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Moya


let  provider  = MoyaProvider<APPRequest>()

public enum APPRequest {
    case limitList(Int) //限免列表
    case salesList(Int) //降价列表
    case freeList(Int) //免费列表
    case appDetail(String) //应用详情
    case recommendList(String,String)//周边 可传经纬度longitude=116.344539 & latitude=40.034346
}

extension APPRequest : TargetType {
    public var baseURL: URL {
        return URL(string: "http://iappfree.candou.com:8080")!
    }
    
    public var path: String {
        switch self {
        case .limitList(_):
            return "/free/applications/limited"
        case .salesList(_):
            return "/free/applications/sales"
        case .freeList(_):
            return "/free/applications/free"
        case .appDetail(let appId):
            return "/free/applications/\(appId)"
        case .recommendList(_, _):
            return "/free/applications/recommend"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        switch self {
        case .limitList(let page):
            var params: [String: Any] = [:]
            params["page"] = page
            params["currency"] = "rmb"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        case .salesList(let page):
            var params: [String: Any] = [:]
            params["page"] = page
            params["currency"] = "rmb"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        case .freeList(let page):
            var params: [String: Any] = [:]
            params["page"] = page
            params["currency"] = "rmb"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        case .appDetail(_):
            var params: [String: Any] = [:]
            params["currency"] = "rmb"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        case .recommendList(let lon, let lat):
            var params: [String: Any] = [:]
            params["currency"] = "rmb"
            params["longitude"] = lon
            params["latitude"] = lat
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
            
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
}
