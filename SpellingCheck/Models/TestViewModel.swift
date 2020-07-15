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
    @Published var finished: Bool = false
    @Published var mode: DisplayMode = DisplayMode.test
    @Published var progress: Int = 0
    @Published var currentSpelling: ResultType = .notSpelled

    var words = [Word]()
    var results = [WordResult]()

    var currentWord: Word {
        return words[progress]
    }

    init() {
        load()

        progress = 0
        correctAnswers = 0
        finished = false
        results = []
        mode = DisplayMode.test
    }
    
    func load() {
        let test = Bundle.main.decode(Test.self, from: "SpellingTest1.json")
        title = test.title
        words = test.words
    }
    
    func finish() {
        for index in progress + 1 ..< words.count {
            results.append(
                WordResult(
                    word: words[index].text,
                    spelled: "",
                    resultType: .notSpelled)
            )
        }
        
        mode = DisplayMode.report
    }

    func spell(_ spelling: String) {
        let result = WordResult(
            word: words[progress].text,
            spelled: spelling,
            resultType: words[progress].text == spelling ? .correct : .incorrect)

        results.append(result)

        currentSpelling = result.resultType

        if result.resultType == .correct {
            correctAnswers += 1
        }
    }

    func nextWord() {
        currentSpelling = .notSpelled

        finished = progress + 1 == words.count

        if finished {
            finish()
        } else {
            progress += 1
            speak()
        }
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
    
    static let example = TestViewModel()
}
