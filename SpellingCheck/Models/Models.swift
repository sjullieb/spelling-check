//
//  Word.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/16/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import Foundation

struct Test: Codable {
    var title: String
    var words: [Word]
}

struct Word: Codable, Hashable {
    var text: String
}
 
struct WordResult: Hashable {
    var word: String
    var spelled: String
    var resultType: ResultType
}

enum ResultType {
    case incorrect
    case correct
    case notSpelled
}
