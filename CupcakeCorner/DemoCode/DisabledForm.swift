//
//  DisabledForm.swift
//  CupcakeCorner
//
//  Created by Adam Sayer on 7/8/2024.
//

import SwiftUI

struct DisabledForm: View {
    
    @State private var username = ""
    @State private var email = ""
    
    var disabledForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating Account...")
                }
            }
            .disabled(disabledForm)
        }
    }
}

#Preview {
    DisabledForm()
}
