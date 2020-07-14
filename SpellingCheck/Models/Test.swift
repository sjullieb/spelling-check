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

class Test: ObservableObject {
    @Published var title: String = ""
    @Published var words = [Word]()
    @Published var correctAnswers: Int = 0
    @Published var finished: Bool = false
    @Published var spelledWrong: Dictionary<Word, String> = [:]
    
    let objectWillChange = PassthroughSubject<Test, Never>()

    @Published var mode: DisplayMode = DisplayMode.test {
        didSet {
            objectWillChange.send(self)
        }
    }
    @Published var progress: Int = 0 {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    init() {
        load()

        progress = 0
        correctAnswers = 0
        finished = false
        spelledWrong = [:]
        mode = DisplayMode.test
    }
    
    func load() {
        let test = Bundle.main.decode(TestData.self, from: "SpellingTest1.json")
        title = test.title
        words = test.words
        
        if words.count == 0 {
//            ToDo: Replace with Error message and dismiss view
            fatalError("Test is not loaded. Load the test first.")
        }
    }
    
    func finish() {
        mode = DisplayMode.report
    }
    
    func checkCorrectSpelling(of word: String) -> Bool {
        let correct = words[progress].text == word
        
        if correct {
            correctAnswers += 1
        } else {
            spelledWrong[words[progress]] = word
        }
        
        return correct
    }
    
    func checkTestFinished() -> Bool {
        finished = progress + 1 == words.count
        
        if finished {
            finish()
        } else {
           progress += 1
        }
        
        return finished
    }
    
    func getResultType(index: Int) -> ResultType {
        let word = words[index]

        if (spelledWrong[word] != nil) {
            return ResultType.incorrect
        }
        
        return finished || index < progress ? ResultType.correct : ResultType.notSpelled
    }
    
    func getResults() -> [WordResult] {
        var results = [WordResult]()
        
        for (index, word) in words.enumerated() {
            let spelled = spelledWrong[word]
            let type: ResultType

            if (spelled != nil) {
                type = ResultType.incorrect
            } else {
                type = finished || index < progress ? ResultType.correct : ResultType.notSpelled
            }
            results.append(WordResult(word: word.text, spelled: spelled ?? "", resultType: type))
        }
        
        return results
    }
    
    func speak() {
        let text = words[progress].text
        
        let speechSynthesizer = AVSpeechSynthesizer()
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.rate = AVSpeechUtteranceMaximumSpeechRate / 2.0
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(speechUtterance)
    }
    
    enum DisplayMode {
        case test
        case report
    }
    
    static let example = Test()
}
