//
//  Word.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/16/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import Foundation

struct Word {
    var text: String
    var correct: Bool?
    
    init(text: String) {
        self.text = text
    }
}
