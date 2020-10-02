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
    
    var viewModel: TestViewModel! //System Under Test

    override func setUp() {
        super.setUp()
        viewModel = TestViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testCorrectSpellingNextWordExists() {
        let spelling = viewModel.currentWord.text
        let correctAnswers = viewModel.correctAnswers
        let progress = viewModel.progress
        
        var results = viewModel.results
        results.append(WordResult(word: spelling, spelled: spelling, type: ResultType.correct))
    
        viewModel.checkSpelling(word: spelling)

        // check correst spelling
        XCTAssertEqual(viewModel.correctAnswers, correctAnswers + 1, "Correct answer is not recorded")
        XCTAssertEqual(viewModel.results, results, "Correct result is not recorded")
        // move to the next word
        XCTAssertEqual(viewModel.progress, progress + 1, "Progress is not recorded")
        XCTAssertEqual(viewModel.mode, TestViewModel.DisplayMode.test, "Test doesn't switch to test mode")
    }
    
    func testIncorrectSpellingAndDisplayCorrectSpelling() {
        let spelling = viewModel.currentWord.text + "INCORRECT"
        let word = viewModel.currentWord
        let correctAnswers = viewModel.correctAnswers
        
        var results = viewModel.results
        results.append(WordResult(word: word.text, spelled: spelling, type: ResultType.incorrect))
    
        viewModel.checkSpelling(word: spelling)

        XCTAssertEqual(viewModel.mode, TestViewModel.DisplayMode.correctSpelling, "Test doesn't switch to correst spelling mode")
        XCTAssertEqual(viewModel.results, results, "Incorrect result is not recorded")
        XCTAssertEqual(viewModel.correctAnswers, correctAnswers, "Incorrect answer is recorded")
        XCTAssertNotNil(viewModel.spelledWrong[word])
    }
    
    func testMovingToNextWordAfterDisplayingCorrectSpelling() {
        XCTAssertLessThan(2, viewModel.words.count, "Test should have at least 2 words")
        
        let progress = viewModel.progress
        
        viewModel.checkSpelling(word: viewModel.currentWord.text + "INCORRECT")
        viewModel.goToNextWord()
        
        XCTAssertEqual(viewModel.progress, progress + 1, "Progress is not recorded")
        XCTAssertEqual(viewModel.mode, TestViewModel.DisplayMode.test, "Test doesn't switch to test mode")
    }
    
    func testTestFinishesAfterLastCorrectWord() {
        for _ in (0 ..< viewModel.words.count) {
            viewModel.checkSpelling(word: viewModel.currentWord.text)
        }
        
        XCTAssertEqual(viewModel.mode, TestViewModel.DisplayMode.report, "Test doesn't switch to report mode")
        XCTAssertEqual(viewModel.words.count, viewModel.results.count, "Results are not recorded")
    }
    
    
    func testTestFinishesAfterLastIncorrectWord() {
        for i in (0 ..< viewModel.words.count) {
            let spelling = viewModel.currentWord.text + (i == viewModel.words.count - 1 ? "INCORRECT" : "")
            viewModel.checkSpelling(word: spelling)
            if i == viewModel.words.count - 1 {
                viewModel.goToNextWord()
            }
        }
        
        XCTAssertEqual(viewModel.mode, TestViewModel.DisplayMode.report, "Test doesn't switch to report mode")
        XCTAssertEqual(viewModel.words.count, viewModel.results.count, "Results are not recorded")
    }
    
    func testAllWordsAreRecordedWhenTestIsAbandoned() {
        XCTAssertLessThan(2, viewModel.words.count, "Test should have at least 2 words")

        viewModel.checkSpelling(word: viewModel.currentWord.text)
        viewModel.finish()

        XCTAssertEqual(viewModel.mode, TestViewModel.DisplayMode.report, "Test doesn't switch to report mode")
        XCTAssertEqual(viewModel.words.count, viewModel.results.count, "Results are not recorded")
        XCTAssertEqual(viewModel.results[viewModel.results.count - 1].type, ResultType.notSpelled, "Results are not correctly recorded")
    }
}
