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
    @ObservedObject var test: TestViewModel

    @State private var correctWordOpacity = 0.0
    @State private var spelledWord: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Progress")
                Text(String(test.progress + 1) + "/" + String(test.words.count))
                    .bold()
                Spacer()
                Text("Correct")
                Text(String(test.correctAnswers))
                    .bold()
            }
            
            Button(action: {
                self.test.speak()
            }) {
                Image(systemName: "speaker.2.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50.0, height:50)
            }
            
            Text("\(test.currentWord.text)")
                .opacity(correctWordOpacity)
                .animation(.easeIn)
            
            TextField("", text: $spelledWord)
                .frame(height: 50)
                .font(Font.system(size: 24, design: .default))
                .border(borderColor, width: 1)
                .animation(.easeIn(duration: 1))
                .multilineTextAlignment(.center)
                .autocapitalization(.allCharacters)
                .disableAutocorrection(true)

            Button(action: {
                self.test.spell(self.spelledWord)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.spelledWord = ""
                    self.test.nextWord()
                }
            }) {
                Text("Next")
                .padding(10)
            }
            .disabled(test.finished)
            
            Button(action: {
                self.test.spell(self.spelledWord)
                self.test.finish()
            }) {
                Text("Finish")
                .padding(10)
            }
            .disabled(test.finished)
            
            Spacer()
        }
        .onAppear() {
            self.test.speak()
        }
        .padding()
        .multilineTextAlignment(.center)
    }

    var borderColor: Color {
        switch test.currentSpelling {
        case .correct:
            return Color.green
        case .incorrect:
            return Color.red
        case .notSpelled:
            return Color.gray
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView(test: (TestViewModel.example))
    }
}
