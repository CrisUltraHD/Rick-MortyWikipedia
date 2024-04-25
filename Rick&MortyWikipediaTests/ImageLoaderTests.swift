//
//  ImageLoaderTests.swift
//  Rick&MortyWikipediaTests
//
//  Created by Cristian Caride on 25/4/24.
//

import XCTest
@testable import Rick_MortyWikipedia // Import the module containing CharacterController

class ImageLoaderTests: XCTestCase {

    var imageLoader: ImageLoader!

    override func setUpWithError() throws {
        imageLoader = ImageLoader()
    }

    override func tearDownWithError() throws {
        imageLoader = nil
    }

    func testLoadImageFromValidURL() throws {
        let validURL = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
        imageLoader.loadImage(from: validURL)

        // Simulate asynchronous operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Check if the image was loaded and stored in the dictionary
            XCTAssertNotNil(self.imageLoader.images[validURL], "Image should be loaded from valid URL")
        }
    }

    func testLoadImageFromInvalidURL() throws {
        let invalidURL = "invalid-url"
        imageLoader.loadImage(from: invalidURL)

        // Simulate asynchronous operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // Check if the image was not loaded for an invalid URL
            XCTAssertNil(self.imageLoader.images[invalidURL], "Image should not be loaded from invalid URL")
        }
    }
}
