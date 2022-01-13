//
//  GetUUIDHandler.swift
//  iOS-Shortcuts
//
//  Created by 王贵彬(lu.com) on 2022/1/13.
//

import Foundation
import UIKit

class GetUUIDHandler : NSObject, GetUUIDStringIntentHandling {
    func handle(intent: GetUUIDStringIntent, completion: @escaping (GetUUIDStringIntentResponse) -> Void) {
        let res = GetUUIDStringIntentResponse(code: .success, userActivity: nil)
        res.uuid = self.getUUIDString()
        completion(res)
    }
    
    func getUUIDString() -> String {
        let uuidRef = CFUUIDCreate(kCFAllocatorDefault)
        let strRef = CFUUIDCreateString(kCFAllocatorDefault, uuidRef)
//        let uuidString = (strRef! as String).replacingOccurrences(of: "-", with: "")
        return (strRef! as String)
    }
}

