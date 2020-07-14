//
//  ReportRow.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/20/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

struct ReportRow: View {
    let word: String
    let resultChar: String
    let resultColor: Color
//    let resultType: ResultType
    let spelled: String
    
    var body: some View {
        HStack {
            Text("\(resultChar)")
                .padding(.leading, 20)
                .foregroundColor(resultColor)
            
            Text("\(word)")
            Spacer()
            
            Text("\(spelled)")
            Spacer()
        }
    }
}


struct ReportRow_Previews: PreviewProvider {
    static var previews: some View {
        ReportRow(word: "ONE", resultChar: "", resultColor: Color.red, spelled: "ONEE")
    }
}
