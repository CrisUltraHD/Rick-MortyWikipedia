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
    
    // State to store the text entered in the search field
    @State private var searchText = ""
    
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            ZStack {
                // Iteration over the list of characters to display their images
                ForEach(characterController.characters.indices, id: \.self) { index in
                    let character = characterController.characters[index]
                    let imageUrl = character.image
                    
                    // Display image if it's available in the image loader
                    if let image = imageLoader.images[imageUrl] {
                        
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.5)
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
                            .offset(x: CGFloat(index - currentIndex) * UIScreen.main.bounds.width * 0.70 + dragOffset, y: 0)
                        
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
        .frame(maxWidth: .infinity * 0.5, maxHeight: .infinity * 0.5)
        
        // TextField for name search
        TextField("\(Image(systemName: "magnifyingglass"))  Search by name", text: $searchText)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .edgesIgnoringSafeArea(.bottom) // Ignorar el borde inferior seguro para que el TextField se extienda hasta abajo
            .onChange(of: searchText) { oldValue, newValue in
                // Update character array every time the search text changes
                updateFilteredCharacters()
            }
            .modifier(KeyboardAwareModifier())
        
        // Navigation bar configuration
            .navigationTitle("Explore All Characters")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
        // Load character data when first appearing
            .onAppear {
                characterController.fetchCharacterData()
            }
        
    }
    func updateFilteredCharacters() {
        if searchText.isEmpty {
            // If search text is empty clean the previous character array and fech all characters
            characterController.characters.removeAll()
            currentIndex = 0
            characterController.fetchCharacterData()
            
        } else {
            // Re load all characters that when filtered got lost
            characterController.fetchCharacterData()
            // Filer characters by search text
            characterController.characters = characterController.characters.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    MainScreen()
}
