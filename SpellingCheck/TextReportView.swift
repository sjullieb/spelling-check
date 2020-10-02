//
//  TextReportView.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 10/1/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

struct TextReportView: View {
    let results: [WordResult]
        
    var body: some View {
        SpelledTextView(result: results)
        
        List {
            ForEach(results, id: \.self) { result in
                ReportRow(result: result)
            }
        }
    }
}

struct TextReportView_Previews: PreviewProvider {
    static var previews: some View {
        TextReportView(results: [WordResult(word: "ONE", spelled: "ONEE", type: .incorrect)])
    }
}
