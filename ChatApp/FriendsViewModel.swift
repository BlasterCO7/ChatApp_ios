//
//  FriendsViewModel.swift
//  ChatApp
//
//  Created by Piyush Anand on 29/10/24.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseAuth

class FriendsViewModel: ObservableObject {
    @Published var friends: [Friend] = []

    private var db = Firestore.firestore()

    init() {
        fetchFriends()
    }

    private func fetchFriends() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        db.collection("friends").whereField("userID", isEqualTo: userID).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else {
                print("No friends found")
                return
            }
            self.friends = documents.compactMap { doc in
                let data = doc.data()
                return Friend(id: doc.documentID, name: data["username"] as? String ?? "")
            }
        }
    }

    func addFriend(username: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        db.collection("users").whereField("username", isEqualTo: username).getDocuments { (snapshot, error) in
            if let documents = snapshot?.documents, let friendDoc = documents.first {
                let friendID = friendDoc.documentID
                self.db.collection("friends").addDocument(data: [
                    "userID": userID,
                    "friendID": friendID,
                    "username": username
                ]) { error in
                    if let error = error {
                        print("Error adding friend: \(error)")
                    } else {
                        self.fetchFriends() // Refresh friend list
                    }
                }
            } else {
                print("No user found with that username.")
            }
        }
    }
}

