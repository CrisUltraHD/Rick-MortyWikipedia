//
//  KeyboardAwareModifier.swift
//  Rick&MortyWikipedia
//
//  Created by Cristian Caride on 25/4/24.
//

import SwiftUI

/// A modifier that adjusts the position of the view when the keyboard appears or disappears.
struct KeyboardAwareModifier: ViewModifier {
    // State variable to track the height of the keyboard
    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {
        content
            // Add padding to the bottom of the view equal to the keyboard height
            .padding(.bottom, keyboardHeight)
            .onAppear {
                // Observe keyboard show notification
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                    // Extract the keyboard frame from the notification
                    guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                    // Update the keyboard height state variable
                    self.keyboardHeight = keyboardFrame.height
                }

                // Observe keyboard hide notification
                NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                    // Reset the keyboard height state variable to 0
                    self.keyboardHeight = 0
                }
            }
    }
}
