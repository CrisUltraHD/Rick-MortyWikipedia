//
//  WelcomeScreen.swift
//  Rick&MortyWikipedia
//
//  Created by Cristian Caride on 24/4/24.
//

import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        VStack {
            Text("Welcome To Rick & Morty Characters Wikipedia!")
                .multilineTextAlignment(.leading)
                .bold()
                .padding()
                .frame(maxWidth: .infinity)
                

                    
            Button(action: {}){
                Image(systemName: "arrow.right.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30) // Adjust size as needed

            }
            .padding(5)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image("Background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all) // Fill the entire screen

        )
    }
        
}

#Preview {
    WelcomeScreen()
}
