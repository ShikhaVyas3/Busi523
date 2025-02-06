//
//  ResultsView.swift
//  busi523
//
//  Created by Shikha Vyas on 2/4/25.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var gameManager: GameManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack {
                        Text("Results")
                            .font(.largeTitle)
                            .fontDesign(.serif)
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                        
                        HStack(alignment: .top) {
                            VStack {
                                Text("Male Choices")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .fontDesign(.serif)
                                    .underline()
                                ForEach(gameManager.selectedFields.filter { $0.gender == "Male" },
                                        id: \.field.name)
                                { item in
                                    Text(item.field.name)
                                        .padding(5)
                                        .foregroundStyle(.white)
                                        .lineLimit(1)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            
                            VStack {
                                Text("Female Choices")
                                    .font(.title2)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .fontDesign(.serif)
                                    .underline()
                                ForEach(gameManager.selectedFields.filter { $0.gender == "Female" },
                                        id: \.field.name)
                                { item in
                                    Text(item.field.name)
                                        .padding(5)
                                        .foregroundStyle(.white)
                                        .lineLimit(1)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding()
                        
                        VStack(spacing: 16) {
                            
                            Button("Restart Game") {
                                            gameManager.currentIndex = 0
                                            gameManager.selectedFields.removeAll()
                                            gameManager.showResults = false
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                        .padding()
                                        .background(Color.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                    
                            
                            NavigationLink(destination: ActualView()) {
                                HStack {
                                    Text("Show Actual Statistics")
                                        .foregroundColor(.white)
                                        .bold()
                                        .italic()
                                    Image(systemName: "arrow.forward")
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.7))
                                .cornerRadius(10)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

#Preview {
    ResultsView().environmentObject(GameManager())
}
