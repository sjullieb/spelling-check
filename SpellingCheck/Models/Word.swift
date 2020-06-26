//
//  Word.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/16/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import Foundation

struct Test: Codable {
    var name: String
    var words: [Word]
    
    static let example = Test(name: "Test 1", words: [Word.example])
}

struct Word: Codable, Hashable {
    var text: String
    
    static let example = Word(text: "test")
}
