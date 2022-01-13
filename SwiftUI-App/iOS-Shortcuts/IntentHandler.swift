//
//  IntentHandler.swift
//  iOS-Shortcuts
//
//  Created by 王贵彬(lu.com) on 2022/1/13.
//

import Intents

class IntentHandler: INExtension {

    override func handler(for intent: INIntent) -> Any {
        switch intent {
        case is GetUUIDStringIntent:
            return GetUUIDHandler()
        case is MakeUppercaseIntent:
            return MakeUppercaseIntentHandler()
        case is MakeLowercaseIntent:
            return MakeLowercaseIntentHandler()

        default:
            fatalError("No handler for this intent")
        }
    }

}
