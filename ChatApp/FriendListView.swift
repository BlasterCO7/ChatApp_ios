//
//  FriendListView.swift
//  ChatApp
//
//  Created by Piyush Anand on 29/10/24.
//

import SwiftUI

struct FriendsListView: View {
    @StateObject private var friendsViewModel = FriendsViewModel()
    @State private var newFriendUsername: String = ""
    @State private var showAddFriendView: Bool = false

    var body: some View {
        NavigationView {
            VStack {
                List(friendsViewModel.friends) { friend in
                    NavigationLink(destination: ChatLogView(friend: friend)) {
                        Text(friend.name)
                            .font(.headline)
                            .padding()
                    }
                }
                
                Button(action: {
                    showAddFriendView.toggle()
                }) {
                    Text("Add Friend")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .sheet(isPresented: $showAddFriendView) {
                    AddFriendView { username in
                        friendsViewModel.addFriend(username: username)
                    }
                }
            }
            .navigationTitle("Friends")
        }
    }
}

