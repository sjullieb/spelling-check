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
        case word, spelled, type//resultType = "result"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(word, forKey: .word)
        try container.encode(spelled, forKey: .spelled)
        try container.encode(type.rawValue, forKey: .type)
    }
    
//    init(from decoder: Decoder) throws {
        
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let key = container.allKeys.first
//
//        switch key {
//        case .word:
//            self.word = .word
//        case .spelled:
//            self = .spelled
//        case .result:
//            self = ResultType(rawValue)
//        default:
//            throw DecodingError.dataCorrupted(
//                DecodingError.Context(
//                    codingPath: container.codingPath,
//                    debugDescription: "Unabled to decode enum."
//                )
//            )
//        }
//    }
    
//    func encode(to encoder: Encoder) throws {
//      var container = encoder.container(keyedBy: CodingKeys.self)
//      try container.encode(name, forKey: .name)
//      try container.encode(id, forKey: .id)
//      // 4
//      var giftContainer = container
//        .nestedContainer(keyedBy: GiftKeys.self, forKey: .gift)
//      try giftContainer.encode(favoriteToy, forKey: .toy)
//    }
}

struct TestResult: Codable {
    var title: String
    var timestamp: Date
    var words: [WordResult]
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
