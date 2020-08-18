//
//  SpellingCheckTests.swift
//  SpellingCheckTests
//
//  Created by Yulia Shidlovskaya on 7/30/20.
//  Copyright © 2020 sjullieb. All rights reserved.
//

import XCTest
@testable import SpellingCheck

class SpellingCheckTests: XCTestCase {
    
    var sut: TestViewModel! //System Under Test

    override func setUp() {
        super.setUp()
        sut = TestViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
//    func testCorrectSpellingIsRecorded() {
//        let correctSpelling = sut.currentWord.text
//
//        sut.checkSpelling(word: correctSpelling)
//
//        XCTAssertEqual(sut.correctAnswers, 1)
//    }
//
//    func testWrondSpellingIsNotRecorded() {
//        let incorrectSpelling = sut.currentWord.text + "INCORRECT"
//
//        sut.checkSpelling(word: incorrectSpelling)
//
//        XCTAssertEqual(sut.correctAnswers, 0)
//    }
//
//    func testProgressIsRecorded() {
//        let correctSpelling = sut.currentWord.text
//        let progress = sut.progress
//
//        sut.checkSpelling(word: correctSpelling)
//
//        XCTAssertEqual(sut.progress, progress + 1)
//    }
//
//    func testGoToNextWordWhenItExists() {
//        let nextWord = sut.progress < sut.words.count - 1 ? sut.words[sut.progress + 1] : nil
//
//        sut.goToNextWord()
//
//        XCTAssertEqual(sut.currentWord, nextWord)
//    }
//
//    func testTestIsFinishedIfNoWordsLeft() {
//        let nextWord = sut.progress < sut.words.count - 1 ? sut.words[sut.progress + 1] : nil
//
//        sut.goToNextWord()
//
//        XCTAssertEqual(sut.currentWord, nextWord)
//    }
//
//    func testTestIsNotFinishedWhenNextWordExists() {
////        ToDo
//    }
    
//     -------------------------------
//     new tests
    
    func testCorrectSpellingIsRecorded() {
        let spelling = sut.currentWord.text
        let correctAnswers = sut.correctAnswers
//        let currentSpellingType = ResultType.notSpelled
        
        var results = sut.results
        results.append(WordResult(word: spelling, spelled: spelling, type: ResultType.correct))
    
        sut.checkSpelling(word: spelling)

        XCTAssertEqual(sut.correctAnswers, correctAnswers + 1, "Correct answer is not recorded")
//        XCTAssertEqual(sut.currentSpellingType, ResultType.correct, "Spelling type is not correct")
        XCTAssertEqual(sut.results, results, "Correct result is not recorded")
    }
    
    func testIncorrectSpellingIsRecorded() {
        let spelling = sut.currentWord.text + "INCORRECT"
        let word = sut.currentWord
        var results = sut.results
        results.append(WordResult(word: word.text, spelled: spelling, type: ResultType.incorrect))
    
        sut.checkSpelling(word: spelling)

        XCTAssertEqual(sut.mode, TestViewModel.DisplayMode.spelling, "Test doesn't switch to spelling mode")
        XCTAssertEqual(sut.results, results, "Incorrect result is not recorded")
        XCTAssertNotNil(sut.spelledWrong[word])
    }
    
    func testMovingToNextWordWhenItExists() {
        XCTAssertLessThan(2, sut.words.count, "Test should have at least 2 words")
        
        let progress = sut.progress
        
        sut.checkSpelling(word: sut.currentWord.text)
        
        XCTAssertEqual(sut.progress, progress + 1, "Progress is not recorded")
        XCTAssertEqual(sut.mode, TestViewModel.DisplayMode.test, "Test doesn't switch to test mode")
    }
    
    func testTestFinishesWhenNoWordsLeft() {
        for _ in (0 ..< sut.words.count) {
            sut.checkSpelling(word: sut.currentWord.text)
        }
        
        XCTAssertEqual(sut.mode, TestViewModel.DisplayMode.report, "Test doesn't switch to report mode")
        XCTAssertEqual(sut.words.count, sut.results.count, "Results are not recorded")
    }
    
    // test that all unspelled words are recorded when a user clicks finish button in the middle of the test
    func testAllWordsAreRecordedWhenTestFinishes() {
        XCTAssertLessThan(2, sut.words.count, "Test should have at least 2 words")

        sut.checkSpelling(word: sut.currentWord.text)
        sut.finish()

        XCTAssertEqual(sut.mode, TestViewModel.DisplayMode.report, "Test doesn't switch to report mode")
        XCTAssertEqual(sut.words.count, sut.results.count, "Results are not recorded")
    }
}
