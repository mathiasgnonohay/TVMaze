//
//  String+Extension.swift
//  TVMaze App
//
//  Created by Mathias Nonohay on 13/12/24.
//

import Foundation

extension String {
    
    func htmlToString() -> String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return attributedString.string
        } catch  {
            print("Error converting HTML to String: \(error)")
            return self
        }
    }
    
    
}
