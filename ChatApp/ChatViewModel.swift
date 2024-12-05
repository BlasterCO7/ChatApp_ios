//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Piyush Anand on 29/10/24.
//

import Foundation
import FirebaseFirestore
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var currentMessage: String = ""

    private var db = Firestore.firestore()
    var friendID: String

    init(friendID: String) {
        self.friendID = friendID
        fetchMessages()
    }

    func sendMessage(senderID: String) {
        guard !currentMessage.isEmpty else { return }

        let newMessage = Message(id: UUID().uuidString,
                                 text: currentMessage,
                                 senderID: senderID,
                                 receiverID: friendID,
                                 timestamp: Date())
        
        saveMessage(newMessage)
        currentMessage = ""
    }

    private func saveMessage(_ message: Message) {
        db.collection("messages").addDocument(data: message.toDictionary()) { error in
            if let error = error {
                print("Error sending message: \(error)")
            }
        }
    }

    private func fetchMessages() {
        db.collection("messages")
            .whereField("senderID", in: [friendID, "CurrentUserID"])
            .whereField("receiverID", in: [friendID, "CurrentUserID"])
            .order(by: "timestamp")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("No documents: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                self?.messages = documents.compactMap { doc in
                    return Message(document: doc.data())
                }
            }
    }
}
