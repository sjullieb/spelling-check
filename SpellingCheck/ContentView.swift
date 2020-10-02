//
//  ContentView.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/25/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var wordsTestStarted = false
    @State var textTestStarted = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: MainTestView(), isActive: $wordsTestStarted) {
                    EmptyView()
                }
                Button(action: {
                    self.wordsTestStarted = true
                }) {
                    Text("Words")
                }
                
                NavigationLink(destination: MainTextTestView(), isActive: $textTestStarted) {
                    EmptyView()
                }
                Button(action: {
                    self.textTestStarted = true
                }) {
                    Text("Text")
                }
                .padding(20)
            }.navigationBarTitle("Spelling Check")
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
