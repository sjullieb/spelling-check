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

struct TestView: View {
    @EnvironmentObject var test: CurrentTest

    @Binding var selection: ShownView?

    @State private var borderColor = Color.gray
    @State private var correctWord = " "
    @State private var spelledWord: String = ""
    
    var body: some View {
            VStack {
                HStack {
                    Text("Progress")
                    Text(String(test.progress + 1) + "/" + String(test.dict.count))
                        .bold()
                    Spacer()
                    Text("Correct")
                    Text(String(test.correctAnswers))
                        .bold()
                }
                
                Button(action: {
                    Bundle.main.speak(text: self.test.dict[self.test.progress].text)
                }) {
                    Image(systemName: "speaker.2.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50.0,height:50)
                }
                
                Text("\(correctWord)")
                
                TextField("", text: $spelledWord)
                    .frame(height: 50)
                    .font(Font.system(size: 24, design: .default))
                    .border(borderColor, width: 1)
                    .multilineTextAlignment(.center)
                    .autocapitalization(.allCharacters)

                Button(action: {
                    self.acceptSpelledWord()
                    
                }) {
                    Text("Next")
                    .padding(10)
                }
                .disabled(test.finished)
                
                Spacer()

            }
            .padding()
            .multilineTextAlignment(.center)
    }
    
    private func acceptSpelledWord() {
        let correct = spelledWord == test.dict[test.progress].text
        let currentWord = test.dict[test.progress].text
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.test.acceptWord(spelledWord: self.spelledWord)
            
            if !self.test.finished {
                Bundle.main.speak(text: self.test.dict[self.test.progress].text)
            } else {
                self.selection = ShownView.report
            }
        }
        
        updateUI(color: correct ? Color.green : Color.red,
                word: correct ? " " : currentWord)
    }
    
    private func updateUI(color: Color, word: String) {
        borderColor = color
        correctWord = word
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.borderColor = Color.gray
            self.spelledWord = ""
            self.correctWord = " "
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(selection: .constant(ShownView.test))
    }
}
