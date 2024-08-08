//
//  InternetImages.swift
//  CupcakeCorner
//
//  Created by Adam Sayer on 6/8/2024.
//

import SwiftUI

struct InternetImages: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
                
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    InternetImages()
}
