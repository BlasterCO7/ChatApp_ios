//
//  MessageRow.swift
//  ChatApp
//
//  Created by Piyush Anand on 29/10/24.
//

import SwiftUI

struct MessageRow: View {
    let message: Message
    let isCurrentUser: Bool

    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
                Text(message.text)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            } else {
                Text(message.senderID) // Display friend name or identifier
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(message.text)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.black)
                Spacer()
            }
        }
        .padding(4)
    }
}
