//
//  MainScreen.swift
//  Rick&MortyWikipedia
//
//  Created by Cristian Caride on 24/4/24.
//

import SwiftUI

struct MainScreen: View {
    
    // MARK: - Properties
    
    // Index of the viewing character
    @State private var currentIndex: Int = 0
    
    // Keep track of the gesture offset
    @GestureState private var dragOffset: CGFloat = 0
    
    // Observed object to manage the list of characters
    @ObservedObject var characterController = CharacterController()
    
    // State object to load images
    @StateObject var imageLoader = ImageLoader() // Declaración correcta
    
    // State to control whether a detail view is presented
    @State private var isPresented = false
    
    // MARK: - Body
    
    var body: some View {
        VStack(){
            ZStack{
                // Iteration over the list of characters to display their images
                ForEach(characterController.characters.indices, id: \.self) { index in
                    let character = characterController.characters[index]
                    let imageUrl = character.image
                    
                    // Display image if it's available in the image loader
                    if let image = imageLoader.images[imageUrl] {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.6)
                            .onTapGesture {
                                // Update the current index when tapping on the image
                                self.currentIndex = index
                                self.isPresented = true
                            }
                        // Overlay on the image with the character name
                            .overlay(
                                Text(characterController.characters[index].name)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.black.opacity(0.5)),
                                alignment: .topLeading
                            )
                            .cornerRadius(25)
                            .opacity(currentIndex == index ? 1.0 : 0.5)
                            .scaleEffect(currentIndex == index ? 1.2 : 0.8)
                            .offset(x: CGFloat(index - currentIndex) * UIScreen.main.bounds.width * 0.75 + dragOffset, y: 0)
                    } else {
                        // Puts a loading text while the image is loading in case image is nil
                        Text("Loading image...")
                            .padding()
                            .onAppear {
                                // Load image when it appears on the screen
                                imageLoader.loadImage(from: imageUrl)
                            }
                    }
                }
            }
            // Gestures to control image switching by swiping left or right
            .gesture(
                DragGesture()
                    .onEnded({ value in
                        let threshold: CGFloat = 50
                        if value.translation.width > threshold {
                            withAnimation {
                                currentIndex = max(0, currentIndex - 1)
                            }
                        } else if value.translation.width < -threshold {
                            withAnimation {
                                currentIndex = min(characterController.characters.count - 1, currentIndex + 1)
                            }
                        }
                        
                        // Load the next page of characters when reaching the end of the list
                        if(currentIndex == characterController.characters.count-1) {
                            characterController.fetchNextPage()
                        }
                    })
            )
            // Show the detail view of the selected character, passing the character by the selected index
            .sheet(isPresented: $isPresented) {
                CharacterDetailViewScreen(character: characterController.characters[currentIndex])
            }
        }
        // Navigation bar configuration
        .navigationTitle("Explore All Characters")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        // Load character data when first appearing screen
        .onAppear {
            characterController.fetchCharacterData()
        }
    }
}

#Preview {
    MainScreen()
}
