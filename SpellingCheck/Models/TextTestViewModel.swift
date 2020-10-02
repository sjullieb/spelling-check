//
//  TextModel.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 9/20/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import AVFoundation
import Foundation
import Combine

class TextTestViewModel: TestViewModel {
    override func load() {
        let test = Bundle.main.decode(TextTest.self, from: "SpellingText1.json")
        title = test.title
        let text = test.text
        
        if text.count == 0 {
//            ToDo: Replace with Error message and dismiss view
            fatalError("Test doesn't contain text. Load the valid test first.")
        } else {
            words = splitText(text)
        }
    }
    
    private func splitText(_ text: String) -> [Word] {
        let words = text.components(separatedBy: " ").map({
            Word(text: $0)
        })
        return words
    }
}
