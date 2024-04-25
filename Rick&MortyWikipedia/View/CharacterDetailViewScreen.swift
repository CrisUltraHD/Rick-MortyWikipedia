//
//  CharacterDetailViewScreen.swift
//  Rick&MortyWikipedia
//
//  Created by Cristian Caride on 25/4/24.
//

import SwiftUI

struct CharacterDetailViewScreen: View {
    
    // MARK: - Properties
    
    // Character to display details for
    let character: Character
    
    // Image loader to load character image
    @StateObject var imageLoader = ImageLoader()
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading) {
            // Check if image is loaded, otherwise display loading text
            if let image = imageLoader.images[character.image] {
                // Character name
                Text(character.name)
                    .font(.title)
                    .fontWeight(.semibold)
                
                // Character image
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300, alignment: .top)
                
                // Character details
                Section{
                    Text(" Status: \(character.status) ")
                    Text(" Species: \(character.species) ")
                    Text(" Gender: \(character.gender) ")
                    Text(" Location: \(character.location.name) ")
                    Text(" Created: \(DateUtils.formatDateString(character.created) ?? "Unknown") ")
                }
                .background(.black)
                .foregroundColor(.white)
                
            } else {
                // Show loading text while image is loading
                Text("Loading image...")
                    .padding()
                    .onAppear {
                        imageLoader.loadImage(from: character.image)
                    }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top) // Align VStack to the top
        .offset(y: 25) // Offset the view to make space for navigation bar
        .presentationDragIndicator(.visible) // Show drag indicator
    }
}

#Preview {
    CharacterDetailViewScreen(character: Character(id: 0, name: "Rick", status: "Unknown", species: "Humanoid", type: "Iberian", gender: "Male", origin: Location(name: "Spain", url: ""), location: Location(name: "", url: ""), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: ["Ep 1"], url: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", created: "Today"))
}
