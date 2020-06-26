//
//  ReportView.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/25/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

enum Spelled {
    case incorrect
    case correct
    case unknown
    
    var info: (char: String, color: Color) {
        switch self {
        case .incorrect:
            return ("\u{2717}", Color.red)
        case .correct:
            return ("\u{2713}", Color.green)
        case .unknown:
            return ("?", Color.blue)
        }
    }
}

struct ReportView: View {
    @EnvironmentObject var test: CurrentTest
//    let words: [Word]
//    let wrongWords: Dictionary<Word, String>
//    let progress: Int
//    let done: Bool
        
    var body: some View {
        List {
            ForEach(0 ..< test.dict.count) { index in
                ReportRow(
                    word: self.test.dict[index],
                    correct: self.getSpelledType(word: self.test.dict[index], index: index),
                    spelled: self.test.spelledWrong[self.test.dict[index]]
                )
            }
        }
    }
    
    private func getSpelledType(word: Word, index: Int) -> Spelled {
        if (test.spelledWrong[word] != nil) {
            return Spelled.incorrect
        }
        
        return test.finished || index < test.progress ? Spelled.correct : Spelled.unknown
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}
