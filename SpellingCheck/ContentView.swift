//
//  ContentView.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/25/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var testStarted = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: MainTestView(), isActive: $testStarted) {
                    EmptyView()
                }
                Button(action: {
                    self.testStarted = true
                }) {
                    Text("Start the test")
                }
            }.navigationBarTitle("Spelling Check")
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
