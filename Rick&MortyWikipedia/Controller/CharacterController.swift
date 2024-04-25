//
//  CharacterController.swift
//  Rick&MortyWikipedia
//
//  Created by Cristian Caride on 24/4/24.
//

import Foundation

class CharacterController: ObservableObject {
    // Array of the characters
    @Published var characters: [Character] = []
    
    // URL of the next page of characters
    var nextPageURL: URL? = URL(string: "https://rickandmortyapi.com/api/character?page=1")
    
    // Function to fetch character data
    func fetchCharacterData() {
        // Check if the URL is valid
        guard let url = URL(string: "https://rickandmortyapi.com/api/character?page=1") else {
            print("Invalid URL")
            return
        }
        
        // Call function to fetch characters
        fetchCharacters(from: url)
    }
    
    // Function to fetch the next page of characters
    func fetchNextPage() {
        // Check if there is a URL for the next page
        guard let nextPageURL = nextPageURL else {
            print("No URL for the next page available")
            return
        }
        
        // Call function to fetch characters from the next page
        fetchCharacters(from: nextPageURL)
    }
    
    // Private function to fetch characters from a given URL
    private func fetchCharacters(from url: URL) {
        // Create a session task to fetch data from the URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check if there is data and if there is any error
            guard let data = data, error == nil else {
                print("Error fetching character data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Decode the received data into a character response
            do {
                let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                // Update the character list and the URL of the next page on the main thread
                // By performing these updates on the main thread, we ensure that any changes to the UI based on the updated data will be reflected smoothly and without causing any UI-related issues.
                DispatchQueue.main.async {
                    self.characters.append(contentsOf: response.results)
                    self.nextPageURL = URL(string: response.info.next ?? "")
                }
            } catch {
                // Handle decoding errors
                print("Error decoding character data: \(error.localizedDescription)")
            }
        }.resume() // Start the session task
    }
}
