//
//  ContentView.swift
//  WordScramble
//
//  Created by Pogos Anesyan on 08.03.2021.
//

import SwiftUI

struct ContentView: View {

    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .padding()
                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
                Text("Your score is \(score)")
                    .font(.system(size: 45, weight: .bold, design: .rounded))
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(trailing: Button(action: startGame, label: {
                Image(systemName: "arrow.clockwise")
            }))
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError, content: {
                Alert(title: Text(errorTitle),
                      message: Text(errorMessage),
                      dismissButton: .default(Text("OK")))
            })
        }
    }

    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }

        guard isOriginal(word: answer) || answer == newWord else {
            wordError(title: "Word used already", message: "Be more original")
            score -= 1
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not recognized",
                      message: "You can't just make them up, you know")
            score -= 1
            return
        }
        
        guard isReal(word: answer) || answer.count < 3 else {
            wordError(title: "Word not possible",
                      message: "That isn't real word")
            score -= 1
            return
        }

        usedWords.insert(answer, at: 0)
        score += newWord.count
        newWord = ""
    }

    func startGame() {
        usedWords = []
        score = 0
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: ".txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "slikworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        for latter in word {
            if let pos = tempWord.firstIndex(of: latter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0,
                            length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
