//
//  MainTestView.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/25/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

struct MainTestView: View {
    @ObservedObject var test = Test()
    
    var body: some View {
        VStack {
            if test.mode == Test.DisplayMode.test
            {
                TestView(test: test)
            } else if test.mode == Test.DisplayMode.report {
                ReportView(results: test.getResults())
            }
        }
    }
}

struct MainTestView_Previews: PreviewProvider {
    static var previews: some View {
        MainTestView()
    }
}
