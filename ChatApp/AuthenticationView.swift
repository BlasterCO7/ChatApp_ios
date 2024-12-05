//
//  AuthenticationView.swift
//  ChatApp
//
//  Created by Piyush Anand on 29/10/24.
//
import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct AuthView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isSignUp: Bool = false
    @State private var errorMessage: String = ""
    @State private var isAuthenticated: Bool = false

    var body: some View {
        VStack {
            Text(isSignUp ? "Sign Up" : "Log In")
                .font(.largeTitle)
                .padding()

            TextField("Email", text: $email)
                .onChange(of: email) { newValue in
                                    email = newValue.lowercased()
                        }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                if isSignUp {
                    signUp()
                } else {
                    logIn()
                }
            }) {
                Text(isSignUp ? "Create Account" : "Log In")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            Button(action: {
                isSignUp.toggle()
            }) {
                Text(isSignUp ? "Already have an account? Log In" : "Don't have an account? Sign Up")
                    .foregroundColor(.blue)
            }
            .padding()
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .onAppear {
            checkIfAuthenticated()
        }
    }

    private func logIn() {
        guard !email.isEmpty, !password.isEmpty else {
                    errorMessage = "Email and password cannot be empty."
                    return
                }
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isAuthenticated = true
            }
        }
    }

    private func signUp() {
        
        guard !email.isEmpty, !password.isEmpty else {
                errorMessage = "Email and password cannot be empty."
                return
            }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                isAuthenticated = true
            }
        }
    }

    private func checkIfAuthenticated() {
        if Auth.auth().currentUser != nil {
            isAuthenticated = true
        }
    }
}
