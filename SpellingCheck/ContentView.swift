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

enum Spelled {
    case incorrect
    case correct
    case unknown
    
    var info: (char: String, color: Color) {
        switch self {
        case .incorrect:
            return ("\u{2717}", Color.red)
        case .correct:
            return ("\u{2713}", Color.green)
        case .unknown:
            return ("?", Color.blue)
        }
    }
}

class TestingWord {
    var text: String = ""
    var correct = Spelled.unknown
    
    init(text: String) {
        self.text = text.uppercased()
    }
    static let example = TestingWord(text: "Hello")
}

class TestingDictionary: ObservableObject {
    @Published var store = [TestingWord]()
    
    init(store: [TestingWord]) {
        self.store = store
    }
}

struct ContentView: View {
    
    @State private var testProgress: Int = 0
    @State private var numberOfItems: Int = 3
    @State private var correctAnswers: Int = 0
    @State private var testDone: Bool = false
    @State private var isShowingReport: Bool = false
    @State private var borderColor = Color.gray
    @State private var correctSpelling = " "
        
    @ObservedObject var dictionary = TestingDictionary(
        store:
            [TestingWord(text: "one"),
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
                .padding([.leading, .trailing, .top], 20)
                
                Button(action: {
                    // read the word
                }) {
                    Image(systemName: "speaker.2.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50.0,height:50)
                }
                
                Text("\(correctSpelling)")
                
                TextField("", text: $typedWord)
                    .frame(height: 50)
                    .font(Font.system(size: 24, design: .default))
                    .border(borderColor, width: 1)
                    .padding([.leading, .trailing], 20)
                    .multilineTextAlignment(.center)
                    .autocapitalization(.allCharacters)

                Button(action: {
                    let correct = self.typedWord == self.dictionary.store[self.testProgress].text
                    
                    self.dictionary.store[self.testProgress].correct = correct ?     Spelled.correct : Spelled.incorrect
                    
                    self.correctAnswers += correct ? 1 : 0
                    self.correctSpelling = correct ? " " : self.dictionary.store[self.testProgress].text
                    self.borderColor = correct ? Color.green : Color.red
                    self.testProgress += 1
                    self.testDone = self.testProgress == self.dictionary.store.count
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.borderColor = Color.gray
                        self.typedWord = ""
                        self.isShowingReport = self.testProgress == self.dictionary.store.count
                        self.correctSpelling = " "
                    }
                    
                }) {
                    Text("Next")
                    .padding(10)
                   
                }
                 .disabled(testDone)
                
                NavigationLink(destination: ReportView(), isActive: $isShowingReport) { EmptyView() }
                
                Button("Report") {
                    self.isShowingReport = true
                }
                .padding(10)
                
                Spacer()

            }
            .navigationBarTitle("Spelling Test")
            .multilineTextAlignment(.center)

        }.environmentObject(dictionary)
    }
}

struct ReportView: View {
    @EnvironmentObject var dictionary: TestingDictionary
    
    var body: some View {
        List {
            ForEach(0 ..< dictionary.store.count) { index in
                ReportRow(word: self.dictionary.store[index])
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
