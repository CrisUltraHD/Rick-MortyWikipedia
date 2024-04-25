//
//  ImageLoader.swift
//  Rick&MortyWikipedia
//
//  Created by Cristian Caride on 25/4/24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    // Dictionary to cache loaded images
    @Published var images: [String: UIImage] = [:]
    // Set to hold cancellable objects
    private var cancellables: Set<AnyCancellable> = []
    
    // Load image from URL
    func loadImage(from urlString: String) {
        // Check if the URL is valid
        guard let url = URL(string: urlString) else {
            return
        }
        
        // Create a data task publisher for the URL
        URLSession.shared.dataTaskPublisher(for: url)
            // Map received data to a UIImage
            .map { UIImage(data: $0.data) }
            // Replace any errors with nil
            .replaceError(with: nil)
            // Receive data on the main thread
            .receive(on: DispatchQueue.main)
            // Sink to handle received image
            .sink { [weak self] image in
                // Ensure image is not nil, then cache it in the images dictionary
                guard let image = image else { return }
                self?.images[urlString] = image
            }
            // Store the cancellable object
            .store(in: &cancellables)
    }
}
