//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Pogos Anesyan on 29.01.2021.
//

import SwiftUI

struct ContentView: View {

	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	@State private var showingScore = false
	@State private var scoreTitle = ""
	@State private var alertText = ""
	@State private var totalScore = 0
	@State private var angle = 0.0
	@State private var opacityValue = 1.0
	@State private var tappedFlag = 0
	@State private var hasGuessed = false
	@State private var size: CGFloat = 1.0
	@State private var isWrongAnimationStoped = false

	var body: some View {
		ZStack {
			LinearGradient(gradient: Gradient(colors: [.black, .blue]), startPoint: .top, endPoint: .bottom)
				.edgesIgnoringSafeArea(.all)
			VStack(spacing: 30) {
				Spacer()
				VStack {
					Text("Tap the flag of")
						.foregroundColor(.white)
					Text(countries[correctAnswer])
						.foregroundColor(.white)
						.font(.largeTitle)
						.fontWeight(.black)
					Text("\(totalScore)")
						.foregroundColor(.white)
						.font(.largeTitle)
						.fontWeight(.black)
				}

				ForEach(0 ..< 3) { number in
					Button(action: {
						tappedFlag = number
						withAnimation(Animation.default.repeatCount(3, autoreverses: true)) {
							self.isWrongAnimationStoped = true
						}
						isWrongAnimationStoped = false
						hasGuessed = true
						self.flagTapped(number)
					}) {
						FlagImage(image: Image(self.countries[number]))
					}
					.animation(nil)
					.opacity(number != tappedFlag ? opacityValue : 1)
					.scaleEffect(number == correctAnswer && hasGuessed ? 1.3 : 1)
					.animation(.default)
					.rotation3DEffect(
						Angle(degrees: number == correctAnswer ? angle : 0),
						axis: (x: 0.0, y: 1.0, z: 0.0)
					)
					.scaleEffect(
						CGSize(width: number != correctAnswer && number == tappedFlag && isWrongAnimationStoped ? 1.5 : 1.0 ,
							   height: number != correctAnswer && number == tappedFlag && isWrongAnimationStoped ? 1.5 : 1.0)
					)
				}
				Spacer()
			}.alert(isPresented: $showingScore) {
				Alert(title: Text(scoreTitle), message: Text("\(alertText)"), dismissButton: .default(Text("Continue")) {
					self.askQuestion()
				})
			}
		}
	}

	func flagTapped(_ number: Int) {
		opacityValue = 0.75
		if number == correctAnswer {
			withAnimation(.default) {
				angle += 360
			}
			totalScore += 1
			DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
				askQuestion()
			}
		} else {
			totalScore -= 1
			scoreTitle = "Wrong! That’s the flag of \(countries[number])"
			alertText = "Your score is \(totalScore)"
			DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
				showingScore = true
			}
		}
	}

	func askQuestion() {
		angle = 0
		opacityValue = 1
		hasGuessed = false
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
