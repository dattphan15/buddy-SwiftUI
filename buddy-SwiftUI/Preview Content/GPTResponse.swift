//
//  BotResponse.swift
//  buddy-SwiftUI
//
//  Created by phantom on 2023-05-15.
//

import Foundation

func getGPTResponse(message: String) -> String {
    let tempMessage = message.lowercased()
    
    if tempMessage.contains("hi") {
        return "Hey there! How can I help you?"
    } else {
        return "Temp demo GPT response"
    }
    
}
