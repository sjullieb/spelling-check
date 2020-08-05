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
                ReportRow(result: result)
            }
        }
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView(results: [WordResult(word: "ONE", spelled: "ONEE", type: .incorrect)])
    }
}
