//
//  ChatLogView.swift
//  ChatApp
//
//  Created by Piyush Anand on 29/10/24.
//
import SwiftUI
import FirebaseAuth

struct ChatLogView: View {
    var friend: Friend
    @StateObject private var chatViewModel: ChatViewModel

    init(friend: Friend) {
        self.friend = friend
        self._chatViewModel = StateObject(wrappedValue: ChatViewModel(friendID: friend.id))
    }

    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatViewModel.messages) { message in
                    MessageRow(message: message, isCurrentUser: message.senderID == Auth.auth().currentUser?.uid)
                }
            }
            .padding(.horizontal)
            
            HStack {
                TextField("Enter message", text: $chatViewModel.currentMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    chatViewModel.sendMessage(senderID: Auth.auth().currentUser?.uid ?? "")
                }) {
                    Text("Send")
                        .bold()
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .navigationTitle(friend.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
