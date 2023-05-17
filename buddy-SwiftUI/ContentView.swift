//
//  ContentView.swift
//  buddy-SwiftUI
//
//  Created by phantom on 2023-05-14.
//

import SwiftUI

struct ContentView: View {
    @State private var messageText = ""
    @State private var isTyping = false
    @State var messages: [String] = ["Welcome to BuddyGPT"]
    
    var body: some View {
        VStack {
            HStack {
                Text("BuddyGPT")
                    .font(.largeTitle)
                    .bold()
                
                Image(systemName: "bubble.left.fill")
                    .font(.system(size: 26))
                    .foregroundColor(Color.blue)
            }
            
            ScrollView {
                ForEach(messages, id: \.self) { message in
                    if message.contains("[USER]") {
                        let newMessage = message.replacingOccurrences(of:
                                                                        "[USER]", with: "")
                        
                        HStack {
                            Spacer()
                            Text(newMessage)
                                .padding()
                                .foregroundColor(.white)
                                .background(.blue.opacity(0.8))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                        }
                    } else {
                        HStack {
                            Text(message)
                                .padding()
                                .background(.gray.opacity(0.15))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                            Spacer()
                        }
                    }
                    
                // Display messages bottom of screen
                }
                .rotationEffect(.degrees(180))
            }
            .rotationEffect(.degrees(180))
            .background(Color.gray.opacity(0.10))
            
            if isTyping {
                TypingIndicatorView()
            }
            
            HStack {
                TextField("Type something", text: $messageText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onSubmit {
                        sendMessage(message: messageText)
                    }
                
                Button {
                    sendMessage(message: messageText)
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                .font(.system(size: 26))
                .padding(.horizontal, 10)
            }
            .padding()
        }
    }
    
    /**
     Sends a user's message to the server and adds the server's response to the messages array.
     
     - Parameter message: The message from the user.
     
     - Returns: Void
     */
    func sendMessage(message: String) {
        withAnimation {
            // Add the user's message to the messages array
            messages.append("[USER]" + message)
            self.messageText = ""
            
            // Indicate that the bot is "typing"
            self.isTyping = true
        }
        // Adds 1sec delay after sending and receiving message
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Send the user's message to the server and handle the response
            getGPTResponse(message: message) { response in
                withAnimation {
                    // Trim the server's response and add it to the messages array
                    let trimmedResponse = response.trimmingCharacters(in: .whitespacesAndNewlines)
                    messages.append(trimmedResponse)
                    
                    // Indicate that the bot has finished "typing"
                    self.isTyping = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
