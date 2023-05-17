//
//  BotResponse.swift
//  buddy-SwiftUI
//
//  Created by phantom on 2023-05-15.
//

import Foundation

/**
 Sends a POST request to the Next.js server with a user's message, and retrieves a response.

 - Parameters:
    - message: The message from the user that will be sent to the server.
    - completion: The callback to trigger after receiving a response from the server. This callback includes the server's response as a parameter.

 - Returns: Void
 */
func getGPTResponse(message: String, completion: @escaping (String) -> Void) {
    // The URL of your Next.js server
    let urlString = "http://localhost:3000/api/getResponse"
    let url = URL(string: urlString)!
    
    // Configure the request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    // Convert the message to JSON and set it as the body of the request
    let json: [String: Any] = ["message": message]
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    request.httpBody = jsonData
    
    // Send the request
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        // If there's no data in the response, print an error and return
        guard let data = data else {
            print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
            return
        }
        
        // Attempt to parse the JSON response
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let gptResponse = json["message"] as? String {
                // If the JSON parsing is successful, update the UI on the main thread
                DispatchQueue.main.async {
                    completion(gptResponse)
                }
            }
        } catch let error as NSError {
            // If JSON parsing fails, print an error
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    
    // Begin the request
    task.resume()
}
