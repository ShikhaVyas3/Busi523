//
//  QuestionView.swift
//  busi523
//
//  Created by Shikha Vyas on 2/4/25.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var gameManager: GameManager
    let fields: [StemField]
    let maxQuestions: Int
    @State private var showPercentages = false

    var body: some View {
        ZStack {
            Color.systemPink.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/ .all/*@END_MENU_TOKEN@*/)
            VStack {
                Text(fields[gameManager.currentIndex].name)
                    .font(.largeTitle)
                    .padding().fontDesign(.serif).foregroundColor(.white)
                
                HStack(spacing: 30) {
                    Button(action: {
                        selectGender(gender: "Male")
                    }) {
                        Text("♂ Man")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        selectGender(gender: "Female")
                    }) {
                        Text("♀ Woman")
                            .padding()
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(15)
                
                if showPercentages {
                    Text("Male: \(fields[gameManager.currentIndex].percentMale)%")
                        .padding(10).fontDesign(.serif).foregroundColor(.white)
                    Text("Female: \(fields[gameManager.currentIndex].percentFemale)%").fontDesign(.serif).foregroundColor(.white)
                    
                    Button(action: {
                        withAnimation {
                            showPercentages = false
                        }
                        if gameManager.currentIndex < maxQuestions - 1 {
                            gameManager.currentIndex += 1
                        } else {
                            gameManager.showResults = true
                        }
                    }) {
                        Text("Next")
                            .font(.system(size: 20, weight: .bold))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 5)
                    }.foregroundColor(.white)
                        .padding(.top, 20)
                }
            }
        }
    }
    
    private func selectGender(gender: String) {
        if !showPercentages {
            gameManager.selectedFields.append((fields[gameManager.currentIndex], gender))
            showPercentages = true
        }
    }
}

#Preview {
    QuestionView(fields: [
        StemField(name: "Chemistry", percentMale: 45, percentFemale: 55)
    ], maxQuestions: 1).environmentObject(GameManager())
}
