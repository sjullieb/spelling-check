//
//  ReportRow.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/20/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

struct ReportRow: View {
    let word: Word
    let correct: Spelled
    let spelled: String?
    
    var body: some View {
        HStack {
            Text("\(correct.info.char)")
                .padding(.leading, 20)
                .foregroundColor(correct.info.color)
            Text("\(word.text)")
            Spacer()
            Text("\(spelled ?? "")")
            Spacer()
        }
    }
}

struct ReportRow_Previews: PreviewProvider {
    static var previews: some View {
        ReportRow(word: Word.example, correct: Spelled.incorrect, spelled: "ONEE")
    }
}
