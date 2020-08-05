//
//  ReportRow.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/20/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

struct ReportRow: View {
    let result: WordResult
    
    var body: some View {
        HStack {
            Text("\(symbol)")
                .padding([.leading, .trailing], 20)
                .foregroundColor(color)
            
            Text("\(result.word)")
            Spacer()
            
            Text("\(spelled)")
            Spacer()
        }
    }
    
    var spelled: String {
        return result.type == .incorrect ? result.spelled : ""
    }
    
    var color: Color {
        switch result.type {
        case .correct:
            return Color.green
        case .incorrect:
            return Color.red
        case .notSpelled:
            return Color.blue
        }
    }
    
    var symbol: String {
        switch result.type {
            case .incorrect:
            return "\u{2717}"
        case .correct:
            return "\u{2713}"
        case .notSpelled:
            return "?"
        }
    }
}

struct ReportRow_Previews: PreviewProvider {
    static var previews: some View {
        ReportRow(result: WordResult(word: "ONE", spelled: "ONEE", type: .incorrect))
    }
}
