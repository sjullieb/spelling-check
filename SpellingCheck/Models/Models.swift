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
 
struct WordResult: Hashable, Codable {
    var word: String
    var spelled: String
    var type: ResultType
    
    enum CodingKeys: String, CodingKey {
        case word, spelled, type
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(word, forKey: .word)
        try container.encode(spelled, forKey: .spelled)
        try container.encode(type.rawValue, forKey: .type)
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        word = try container.decode(String.self, forKey: .word)
//        spelled = try container.decode(String.self, forKey: .spelled)
//        type = try container.decode(ResultType.self, forKey: .type)
//    }
}

struct TestResult: Codable {
    var title: String
    var timestamp: Date
    var words: [WordResult]
}

struct TextTest: Codable {
    var title: String
    var text: String
}

enum ResultType: String, Decodable {
    case incorrect = "incorrect"
    case correct = "correct"
    case notSpelled = "not spelled"
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = ResultType(rawValue: label) ?? .notSpelled
    }
}
