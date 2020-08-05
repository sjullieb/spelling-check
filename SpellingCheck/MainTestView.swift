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
//            switch test.mode {
//            case TestViewModel.DisplayMode.test:
//                TestView(test: test)
//            case TestViewModel.DisplayMode.report:
//                ReportView(results: test.getResults())
//            case TestViewModel.DisplayMode.spelling:
//                ReportView(results: test.getResults())
//            }
            if test.mode == TestViewModel.DisplayMode.test
            {
                TestView(test: test)
            } else if test.mode == TestViewModel.DisplayMode.report {
                ReportView(results: test.results)
            } else if test.mode == TestViewModel.DisplayMode.spelling {
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
