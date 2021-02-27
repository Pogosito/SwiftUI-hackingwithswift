//
//  ContentView.swift
//  Milestone_1
//
//  Created by Pogos Anesyan on 26.02.2021.
//

import SwiftUI

struct ContentView: View {

    private var rockPaperScissors = ["👊🏼", "🤚🏼", "✌🏼"]

    @State private var countOfQuestions = 0
    @State private var iphoneSelection = Int.random(in: 0..<3)
    @State private var savedAnswer = 0
    @State private var score = 0

    @State private var doWeNeedShowAlert = false
    @State private var isShowAnswer = false
    @State private var helperText = "Choose a weapon"

    var body: some View {
        VStack() {
            Spacer()
            Text("Your score: \(score)")
                .fontWeight(.bold)
                .font(.system(.largeTitle, design: .rounded))
                .foregroundColor(.white)
            Text(helperText)
                .fontWeight(.bold)
                .font(.system(.title3, design: .rounded))
                .foregroundColor(.white)
            Spacer()
                Text("\(rockPaperScissors[savedAnswer])")
                    .font(.system(size: 300))
                    .frame(width: 300, height: 300, alignment: .center)
                    .opacity(isShowAnswer ? 1 : 0)
            Spacer()
            HStack {
                ForEach(0..<rockPaperScissors.count) { value in
                    GameButton(action: {
                        tap(of: value)
                    },
                    title: "\(rockPaperScissors[value])")
                        .alert(isPresented: $doWeNeedShowAlert) {
                            Alert(title: Text("Your final score is: \(score)"),
                                  message: Text("Good game"),
                                  dismissButton: Alert.Button.default(Text("Restart"), action: {
                            restart()
                        }))
                    }
                }
            }
            Spacer()
        }
        .frame(minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.368627451, green: 0.9882352941, blue: 0.9098039216, alpha: 1)), Color(#colorLiteral(red: 0.5921568627, green: 0.03137254902, blue: 0.8, alpha: 1))]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
        .ignoresSafeArea()
    }


}

// MARK: - Game procces

private extension ContentView {

    func tap(of: Int) {
        isShowAnswer = true
        perfom(selection: of, rightAnswer: calculateAnswer())
        analysingGame()
        savedAnswer = iphoneSelection
        iphoneSelection = Int.random(in: 0..<3)
    }

    func calculateAnswer() -> Int {
        switch iphoneSelection {
        case 0: return 1
        case 1: return 2
        case 2: return 0
        default: fatalError()
        }
    }

    func analysingGame() {
        countOfQuestions += 1
        if countOfQuestions == 10 {
            doWeNeedShowAlert = true
        }
    }

    func perfom(selection: Int, rightAnswer: Int) {
        if (rightAnswer == selection) {
            score += 1
            helperText = "You won the fight"
        } else if (selection == iphoneSelection) {
            helperText = "You have a draw"
        } else {
            score -= 1
            helperText = "You have lost the battle"
        }
    }

    func restart() {
        countOfQuestions = 0
        isShowAnswer = false
        savedAnswer = 0
        iphoneSelection = Int.random(in: 0..<3)
        helperText = "Choose a weapon"
        score = 0
    }
}

struct GameButton: View {
    
    private let screen = UIScreen.main.bounds

    let action: () -> ()
    let title: String

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(title)
                .font(.largeTitle)
        })
        .frame(width: screen.width / 3 - 20, height: 50, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.7960784314, blue: 1, alpha: 1)),
                                                               Color(#colorLiteral(red: 0.007843137255, green: 0.6117647059, blue: 0.9607843137, alpha: 1)) ]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing))
        .clipShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color.blue, lineWidth: 2)
        )
        .shadow(radius: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
