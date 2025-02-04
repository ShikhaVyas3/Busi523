//
//  ContentView.swift
//  busi523
//
//  Created by Shikha Vyas on 2/4/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameManager = GameManager()
    
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
                    Text("What fields do you think are stereotypicaly male or female?").foregroundStyle(.white).fontDesign(.monospaced)
                    
                    Spacer(minLength: 20)
                    
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
                    
                    Spacer()
                    Spacer()
                }
                .padding(.vertical, 50)
            }.navigationBarBackButtonHidden()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ContentView()
}

