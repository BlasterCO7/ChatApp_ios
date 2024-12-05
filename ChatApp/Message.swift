//
//  Message.swift
//  ChatApp
//
//  Created by Piyush Anand on 29/10/24.
//

import Foundation
import FirebaseFirestore

struct Message: Identifiable {
    var id: String
    var text: String
    var senderID: String
    var receiverID: String
    var timestamp: Date

    init(id: String, text: String, senderID: String, receiverID: String, timestamp: Date) {
        self.id = id
        self.text = text
        self.senderID = senderID
        self.receiverID = receiverID
        self.timestamp = timestamp
    }

    init?(document: [String: Any]) {
        guard let text = document["text"] as? String,
              let senderID = document["senderID"] as? String,
              let receiverID = document["receiverID"] as? String,
              let timestamp = document["timestamp"] as? Timestamp else {
            return nil
        }
        self.id = UUID().uuidString
        self.text = text
        self.senderID = senderID
        self.receiverID = receiverID
        self.timestamp = timestamp.dateValue()
    }

    func toDictionary() -> [String: Any] {
        return [
            "text": text,
            "senderID": senderID,
            "receiverID": receiverID,
            "timestamp": Timestamp(date: timestamp)
        ]
    }
}
