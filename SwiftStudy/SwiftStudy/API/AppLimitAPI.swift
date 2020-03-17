//
//  AppLimitAPI.swift
//  SwiftStudy
//
//  Created by 王贵彬 on 2020/3/17.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

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
        var params: [String: Any] = [:]
        switch self {
        case .limitList(let page):
            params["page"] = page
            params["currency"] = "rmb"
        case .salesList(let page):
            params["page"] = page
            params["currency"] = "rmb"
        case .freeList(let page):
            var params: [String: Any] = [:]
            params["page"] = page
            params["currency"] = "rmb"
        case .appDetail(_):
            var params: [String: Any] = [:]
            params["currency"] = "rmb"
        case .recommendList(let lon, let lat):
            var params: [String: Any] = [:]
            params["currency"] = "rmb"
            params["longitude"] = lon
            params["latitude"] = lat
        default:
            return .requestPlain
        }
        return .requestParameters(parameters: params,
                                  encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
}

///略微封装一下
struct Network {
    static let Provider = MoyaProvider<APPRequest>()
    static func request(_ target:APPRequest,
                        success successCallBack: @escaping (JSON) -> Void,
                        error errorCallBack: @escaping (Int) -> Void,
                        fail failCallBcak: @escaping (MoyaError) -> Void){
        Provider.request(target) { (result) in
            switch result {
            case let .success(response):
                do {
                    try response.filterSuccessfulStatusCodes()
                    let json = try JSON(response.mapJSON())
                    successCallBack(json)
                } catch let error {
                    errorCallBack((error as! MoyaError).response!.statusCode)
                }
            case let .failure(error):
                failCallBcak(error)
            }
        }
        
    }
}


