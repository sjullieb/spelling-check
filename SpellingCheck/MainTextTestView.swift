//
//  MainTestTestView.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 9/30/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

struct MainTextTestView: View {
    @ObservedObject var test = TextTestViewModel()
    
    var body: some View {
        VStack {
            if test.mode == TestViewModel.DisplayMode.test
            {
                TextTestView(test: test)
            } else if test.mode == TestViewModel.DisplayMode.report {
                TextReportView(results: test.results)
            } else if test.mode == TestViewModel.DisplayMode.correctSpelling {
                SpellingView(test: test)
            }
        }
    }
}

struct MainTextTestView_Previews: PreviewProvider {
    static var previews: some View {
        MainTextTestView()
    }
}
