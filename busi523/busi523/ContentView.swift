//
//  ContentView.swift
//  busi523
//
//  Created by Shikha Vyas on 2/4/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.systemPink.ignoresSafeArea()
                VStack(alignment: .center, spacing: 40) {
                    Text("Women in STEM")
                        .font(.largeTitle)
                        .foregroundStyle(Color.white)
                        .bold()
                        .fontDesign(.serif)
                    Text("What fields do you think are stereotypically male or female?")
                        .foregroundStyle(.white)
                        .fontDesign(.monospaced)
                    
                    Spacer(minLength: 80)
                    
                    NavigationLink(destination: GameView().environmentObject(gameManager)) {
                        VStack {
                            Image(systemName: "arrow.forward")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                            Text("Begin")
                                .font(.title)
                                .foregroundColor(.white)
                                .bold()
                                .italic()
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(15)
                    }
                    
                    VStack(alignment: .center, spacing: 20) {
                        Spacer()
                        Text("Select the number of questions:")
                            .font(.headline)
                            .foregroundColor(.white).bold().fontDesign(.monospaced)
                        
                        // Use a Stepper for numeric input.
                        Stepper(value: $gameManager.userQuestionCount,
                                in: 1...(gameManager.fields.isEmpty ? 10 : gameManager.fields.count)) {
                            Text("\(gameManager.userQuestionCount) Questions")
                                .font(.title2).foregroundStyle(.white).fontDesign(.monospaced)
                        }
                    }.padding(.horizontal, 19)
                    
                    Spacer()
                    Spacer()
                }
                .padding(.vertical, 50)
            }
            .navigationBarBackButtonHidden()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ContentView().environmentObject(GameManager())
}


