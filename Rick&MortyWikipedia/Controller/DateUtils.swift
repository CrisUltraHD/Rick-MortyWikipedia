//
//  DateUtils.swift
//  Rick&MortyWikipedia
//
//  Created by Cristian Caride on 25/4/24.
//

import Foundation

class DateUtils {
    // Function to format a date string into a more readable format
    static func formatDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Original date string format
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM d, yyyy 'at' h:mm a" // Desired new format
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}

