//
//  AddFriendView.swift
//  ChatApp
//
//  Created by Piyush Anand on 29/10/24.
//

import SwiftUI

struct AddFriendView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var username: String = ""
    var onAddFriend: (String) -> Void

    var body: some View {
        VStack {
            Text("Add Friend")
                .font(.largeTitle)
                .padding()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                onAddFriend(username)
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Add")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
        .padding()
    }
}
