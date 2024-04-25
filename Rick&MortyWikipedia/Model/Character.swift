//
//  Character.swift
//  Rick&MortyWikipedia
//
//  Created by Cristian Caride on 24/4/24.
//

import Foundation

// Structure representing the response containing character data
struct CharacterResponse: Codable {
    let info: Info
    let results: [Character]
}

// Structure representing pagination information
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// Structure representing the character
struct Character: Identifiable, Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// Structure representing the location
struct Location: Codable {
    let name: String
    let url: String
}
