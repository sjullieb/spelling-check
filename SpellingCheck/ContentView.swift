//
//  ContentView.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/25/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import SwiftUI

enum ShownView {
    case none
    case test
    case report
}

class CurrentTest: ObservableObject {
    @Published var name: String = ""
    @Published var dict = [Word]()
    @Published var progress: Int = 0
    @Published var dictionarySize: Int = 0
    @Published var correctAnswers: Int = 0
    @Published var finished: Bool = false
    @Published var spelledWrong: Dictionary<Word, String> = [:]
    
    func start() {
        if dict.count == 0 {
            fatalError("Test is not loaded. Load the test first.")
        }
        
        progress = 0
        correctAnswers = 0
        dictionarySize = dict.count
        finished = false
        spelledWrong = [:]
    }
    
    func load() {
        let test = Bundle.main.decode(Test.self, from: "SpellingTest1.json")
        name = test.name
        dict = test.words
    }
    
    func acceptWord(spelledWord: String) {
        let correct = dict[progress].text == spelledWord
        
        if !correct {
            spelledWrong[dict[progress]] = spelledWord
        }
        
        finished = progress + 1 == dict.count
        correctAnswers += correct ? 1 : 0
        
        if !finished {
            progress += 1
        }
    }
    
    static let example = CurrentTest()
}

struct ContentView: View {
    @ObservedObject var test = CurrentTest()
    @State var selection: ShownView?
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: TestView(selection: $selection).environmentObject(self.test), tag: ShownView.test, selection: $selection) {
                    EmptyView()
                }
                
                Button(action: {
                    self.test.load()
                    self.test.start()
                    self.selection = ShownView.test
                }) {
                    Text("Start the test")
                }
                
                NavigationLink(destination: ReportView().environmentObject(self.test), tag: ShownView.report, selection: $selection) {
                    EmptyView()
                }
                Button(action: {
                    self.selection = ShownView.report
                }) {
                    Text("Show report")
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
