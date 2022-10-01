//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Zaid Neurothrone on 2022-09-30.
//

import SwiftUI

struct ContentView: View {
  @State private var isShowingScoreAlert = false
  @State private var score = 0
  @State private var scoreTitle = ""
  @State private var alertMessage = ""
  
  @State private var isShowingRestartAlert = false
  @State private var currentQuestion = 0
  
  @State private var correctAnswer = Int.random(in: 0...2)
  @State private var countries = originalCountries.shuffled()
  
  private static let originalCountries = [
    "Estonia",
    "France",
    "Germany",
    "Ireland",
    "Italy",
    "Nigeria",
    "Poland",
    "Russia",
    "Spain",
    "UK",
    "US"
  ]
  
  private let maxQuestions = 8
  
  var body: some View {
    ZStack {
      RadialGradient(stops: [
        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
      ], center: .top, startRadius: 200, endRadius: 400)
      .ignoresSafeArea()
      
      VStack {
        Spacer()
        Text("Guess the Flag")
          .font(.largeTitle.weight(.bold))
          .foregroundColor(.white)
        
        Spacer()
        Spacer()
        Text("Score: \(score)")
          .font(.title.bold())
          .foregroundColor(.white)
        Spacer()
        
        VStack(spacing: 15) {
          Group {
            Text("Tap the flag of")
              .font(.subheadline.weight(.heavy))
            
            Text(countries[correctAnswer])
              .font(.largeTitle.weight(.semibold))
          }
          .foregroundStyle(.secondary)
          
          ForEach(0..<3) { number in
            Button {
              onFlagTappedWith(number)
            } label: {
              FlagImageView(image: countries[number])
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
      }
      .padding()
    }
    .alert(scoreTitle, isPresented: $isShowingScoreAlert) {
      Button("Continue") {
        if currentQuestion == maxQuestions {
          isShowingRestartAlert.toggle()
        } else {
          askQuestion()
        }
      }
    } message: {
      Text(alertMessage)
    }
    .alert("Game Over", isPresented: $isShowingRestartAlert) {
      Button("Restart") {
        restartGame()
      }
    } message: {
      Text("Your score was \(score) / \(maxQuestions)")
    }
  }
}

extension ContentView {
  private func onFlagTappedWith(_ number: Int) {
    let wasCorrect = number == correctAnswer
    scoreTitle = wasCorrect ? "Correct" : "Wrong"
    
    if wasCorrect {
      score += 1
      alertMessage = "Your score is \(score)"
    } else {
      alertMessage = "That's the flag of \(countries[number])"
    }
    
    currentQuestion += 1
    isShowingScoreAlert.toggle()
  }
  
  private func askQuestion() {
    countries.remove(at: correctAnswer)
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
  
  private func restartGame() {
    score = 0
    currentQuestion = 0
    countries = Self.originalCountries
    askQuestion()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
