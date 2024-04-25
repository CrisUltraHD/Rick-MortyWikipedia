//
//  CharacterControllerTests.swift
//  Rick&MortyWikipediaTests
//
//  Created by Cristian Caride on 25/4/24.
//

import XCTest
@testable import Rick_MortyWikipedia // Import the module containing CharacterController

class CharacterControllerTests: XCTestCase {
    
    var characterController: CharacterController!
    
    override func setUp() {
        super.setUp()
        characterController = CharacterController()
    }
    
    override func tearDown() {
        characterController = nil
        super.tearDown()
    }
    
    // Test case to fetch character data
    func testFetchCharacterData() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch character data expectation")
        
        // When
        characterController.fetchCharacterData()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // Check if the character list is not empty after calling fetchCharacterData()
            XCTAssertFalse(self.characterController.characters.isEmpty, "Character list should not be empty after data loading")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }
    
    // Test case to fetch the next page of characters
    func testFetchNextPage() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch next page expectation")
        
        // When
        characterController.fetchNextPage()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // Check if the next page URL is not nil after calling fetchNextPage()
            XCTAssertNotNil(self.characterController.nextPageURL, "Next page URL should not be nil after calling fetchNextPage()")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10)
    }    
}
