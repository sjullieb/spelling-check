//
//  MainTestView.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/25/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

struct MainTestView: View {
    @ObservedObject var test = TestViewModel()
    
    var body: some View {
        VStack {
            if test.mode == TestViewModel.DisplayMode.test
            {
                TestView(test: test)
            } else if test.mode == TestViewModel.DisplayMode.report {
                ReportView(results: test.results)
            } else if test.mode == TestViewModel.DisplayMode.correctSpelling {
                SpellingView(test: test)
            }
        }
    }
}

struct MainTestView_Previews: PreviewProvider {
    static var previews: some View {
        MainTestView()
    }
}
