//
//  WelcomeScreen.swift
//  Rick&MortyWikipedia
//
//  Created by Cristian Caride on 24/4/24.
//

import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        NavigationView{
            VStack {
                // Welcome message
                Text("Welcome To Rick & Morty Characters Wikipedia!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading) // Align text to the top left
                
                // Navigation link to MainScreen
                NavigationLink(destination: MainScreen()) {
                    Image(systemName: "arrow.right.circle")
                        .resizable()
                        .foregroundColor(.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                }
                .padding(5)
                .offset(y: -50) // Move the button up
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                // Background image
                Image("Background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all) // Fill the entire screen ignoring the safe area
            )
        }
        .navigationBarHidden(true) // Hide the navigation bar
    }
}

#Preview {
    WelcomeScreen()
}

