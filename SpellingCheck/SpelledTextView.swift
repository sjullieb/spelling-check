//
//  SpelledText.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 10/1/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

struct SpelledTextView: View {
    let result: [WordResult]
    
    var body: some View {
        result.reduce(Text(""), { $0
                        + decoratedText(word: $1)
                        + Text(" ")}
        )
    }
    
    func decoratedText(word: WordResult) -> Text {
        return Text(word.word)
        .foregroundColor(fontColor(type: word.type))
        .font(.system(size: fontSize(type: word.type)))
    }
    
    func fontColor(type: ResultType) -> Color {
        switch type {
        case .correct:
            return Color.black
        case .incorrect:
            return Color.red
        case .notSpelled:
            return Color.blue
        }
    }
    
    func fontSize(type: ResultType) -> CGFloat {
        switch type {
        case .incorrect:
            return 25.0
        default:
            return 18.0
        }
    }
}
struct SpelledTextView_Previews: PreviewProvider {
    static var previews: some View {
        SpelledTextView(result: [WordResult(word: "ONE", spelled: "ONEE", type: .incorrect), WordResult(word: "TWO", spelled: "TWO", type: .correct)])
    }
}
