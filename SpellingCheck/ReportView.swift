//
//  ReportView.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/25/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

struct ReportView: View {
    let results: [WordResult]
        
    var body: some View {
        List {
            ForEach(results, id: \.self) { result in
                ReportRow(
                    word: result.word,
                    resultChar: "",
                    resultColor: Color.red,
//                    resultType: result.resultType,
                    spelled: result.spelled
                )
            }
        }
    }
}

private func getResultTypeIconAndColor(type: ResultType) -> (char: String, color: Color) {
    switch type {
    case .incorrect:
        return ("\u{2717}", Color.red)
    case .correct:
        return ("\u{2713}", Color.green)
    case .notSpelled:
        return ("?", Color.blue)
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView(results: [WordResult(word: "ONE", spelled: "ONEE", resultType: ResultType.incorrect)])
    }
}
