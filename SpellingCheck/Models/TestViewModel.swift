//
//  Test.swift
//  SpellingCheck
//
//  Created by Yulia Shidlovskaya on 7/10/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import AVFoundation
import Foundation
import Combine

class TestViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var correctAnswers: Int = 0
    @Published var mode: DisplayMode = DisplayMode.test {
        didSet {
            if mode == DisplayMode.test {
                speak()
            }
        }
    }
    @Published var progress: Int = 0
    @Published var spelledWrong: Dictionary<Word, String> = [:]
    @Published var words = [Word]()
    var results = [WordResult]()
    
    var currentWord: Word {
        return words[progress]
    }

    init() {
        load()
    }
    
    func load() {
        let test = Bundle.main.decode(Test.self, from: "SpellingTest1.json")
        title = test.title
        words = test.words
        
        if words.count == 0 {
//            ToDo: Replace with Error message and dismiss view
            fatalError("Test is not loaded. Load the test first.")
        }
    }
    
    func finish() {
        let start = results.count
        for i in (start ..< words.count) {
            results.append(WordResult(word: words[i].text, spelled: "", type: .notSpelled))
        }
        
        mode = DisplayMode.report
        
        let testResult = TestResult(title: title, timestamp: Date(), words: results)
        Bundle.main.encode(testResult, to: "")
        Bundle.main.encode(spelledWrong, to: "")
    }
    
    func checkSpelling(word: String) {
        let correct = (currentWord.text == word)
        let currentSpellingType: ResultType = correct ? .correct : .incorrect
        results.append(WordResult(word: currentWord.text, spelled: word, type: currentSpellingType))

        if correct {
            correctAnswers += 1
            goToNextWord()
        } else {
            spelledWrong[currentWord] = word
            mode = DisplayMode.correctSpelling
        }
    }
    
    func goToNextWord() {
        if progress + 1 == words.count {
            finish()
        } else {
            progress += 1
            mode = DisplayMode.test
        }
    }
    
    func speak() {
        let text = currentWord.text
        
        let speechSynthesizer = AVSpeechSynthesizer()
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(speechUtterance)
    }
    
    enum DisplayMode {
        case test
        case report
        case correctSpelling
    }
    
    static let example = TextTestViewModel()
}
