//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Adam Sayer on 8/8/2024.
//

import SwiftUI

struct CheckoutView: View {
    
    var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                .accessibilityHidden(true)
                
                Text("Your total cost is \(order.cost, format: .currency(code: "AUD"))")
                    .font(.title)
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Chaeckout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("Ok") {}
        } message : {
            Text(confirmationMessage)
        }
        
        .alert("Opps", isPresented: $showingError) {
            Button("Ok") { }
        } message: {
            Text(errorMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            errorMessage = "Sorry, check out failed. \n\n Message:\(error.localizedDescription)"
            showingError = true
        }
    }
}


#Preview {
    CheckoutView(order: Order())
}
