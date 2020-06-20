//
//  ContentView.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 6/15/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

enum Spelled: String {
    case incorrect = "\u{2717}"
    case correct = "\u{2713}"
    case unknown = "?"
}

class TestingWord {
    var text: String = ""
    var correct = Spelled.unknown
    
    init(text: String) {
        self.text = text
    }
}

struct TestingDictionary {
    var store = [TestingWord]()
}

struct ContentView: View {
    
    @State private var testProgress: Int = 0
    @State private var numberOfItems: Int = 3
    @State private var correctAnswers: Int = 0
    @State private var testDone: Bool = false
    @State private var isShowingReport: Bool = false
        
    private var dictionary = TestingDictionary(store: [TestingWord(text: "one"),
                              TestingWord(text: "two"),
                              TestingWord(text: "three")])
    
    @State private var typedWord: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Progress")
                    Text(String(testProgress) + "/" + String(numberOfItems))
                        .bold()
                    Spacer()
                    Text("Correct")
                    Text(String(correctAnswers))
                        .bold()
                }
                .padding(20)
                
                 Button(action: {
                    // read the word
                 }) {
                    Image(systemName: "speaker.2.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50.0,height:50)
                                       .padding(10)
                               }
                 .fixedSize(horizontal: true, vertical: true)
                
                TextField("Type the word", text: $typedWord)
                    .frame(height: 50)
                    .font(Font.system(size: 24, design: .default))
                    .border(Color.gray, width: 1)
                    .padding([.leading, .trailing], 40)
                    .multilineTextAlignment(.center)
                    .autocapitalization(.allCharacters)

                Button(action: {
                    let correct = self.typedWord == self.dictionary.store[self.testProgress].text.uppercased()
                    
                    self.dictionary.store[self.testProgress].correct = correct ? Spelled.correct : Spelled.incorrect
                    
                    self.correctAnswers += correct ? 1 : 0
                    self.testProgress += 1
                    self.typedWord = ""

                    self.testDone = self.testProgress == self.dictionary.store.count
                    self.isShowingReport = self.testProgress == self.dictionary.store.count
                }) {
                    Text("Next")
                    .padding(10)
                   
                }
                 .disabled(testDone)
                
                NavigationLink(destination: ReportView(dict: dictionary), isActive: $isShowingReport) { EmptyView() }
                
                Button("Report") {
                    self.isShowingReport = true
                }
                .padding(10)
                
                Spacer()

            }
            .navigationBarTitle("Spelling Test")
            .multilineTextAlignment(.center)

        }
    }
}

struct ReportView: View {
    let dict: TestingDictionary
    
    var body: some View {
        List {
            ForEach(0 ..< dict.store.count) { index in
                HStack {
                    Text("\(self.dict.store[index].correct.rawValue)")
                    Text("\(self.dict.store[index].text)")
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


