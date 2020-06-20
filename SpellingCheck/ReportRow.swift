//
//  ReportRow.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/20/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

struct ReportRow: View {
    var word: TestingWord
    
    var body: some View {
        HStack {
        Text("\(word.correct.info.char)")
            .padding(.leading, 20)
            .foregroundColor(word.correct.info.color)
        Text("\(word.text)")
        Spacer()
        }
    }
}

struct ReportRow_Previews: PreviewProvider {
    static var previews: some View {
        ReportRow(word: TestingWord.example)
    }
}
