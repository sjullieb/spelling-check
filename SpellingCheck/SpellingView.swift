//
//  SpellingView.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 7/24/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

struct SpellingView: View {
    @ObservedObject var test: TestViewModel

    var body: some View {
        VStack {
            Text("\(test.currentWord.text)")
            Button(action: {
                self.test.goToNextWord()
            }) {
                Text("Ok")
                .padding(10)
            }
        }
    }
}

struct SpellingView_Previews: PreviewProvider {
    static var previews: some View {
        SpellingView(test: (TestViewModel.example))
    }
}
