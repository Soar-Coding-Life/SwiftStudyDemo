//
//  MakeLowercase.swift
//  iOS-Shortcuts
//
//  Created by 王贵彬(lu.com) on 2022/1/13.
//

import Foundation

class MakeLowercaseIntentHandler: NSObject,MakeLowercaseIntentHandling {
    func handle(intent: MakeLowercaseIntent, completion: @escaping (MakeLowercaseIntentResponse) -> Void) {
        if let inputText = intent.text {
            let uppercaseText = inputText.lowercased()
            completion(MakeLowercaseIntentResponse.success(result: uppercaseText))
        } else {
            completion(MakeLowercaseIntentResponse.failure(error: "The entered text was invalid"))
        }

    }
    
}

