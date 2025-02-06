//
//  GameView.swift
//  busi523
//
//  Created by Shikha Vyas on 2/4/25.
//

import SwiftUI

struct StemField: Codable {
    let name: String
    let percentMale: Int
    let percentFemale: Int
}

struct GameView: View {
    @EnvironmentObject var gameManager: GameManager

       
       // The maximum number of questions is the lesser of the user choice and available fields.
       private var maxQuestions: Int {
           min(gameManager.userQuestionCount, gameManager.fields.count)
       }
    
    var body: some View {
        VStack {
            if gameManager.fields.isEmpty {
                Text("Loading data...")
            } else if gameManager.currentIndex < maxQuestions && !gameManager.showResults {
                QuestionView(fields: gameManager.fields, maxQuestions: maxQuestions)
            } else {
                ResultsView()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            loadJSONData()
        }
    }
    
    private func loadJSONData() {
        guard let url = Bundle.main.url(forResource: "StemOptions", withExtension: "json") else {
            print("JSON file not found in bundle")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            print("JSON data loaded, size: \(data.count) bytes")
            
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([String: [StemField]].self, from: data)
            
            guard let stemFields = jsonData["stemFields"] else {
                print("No 'stemFields' key found in JSON")
                return
            }
            
            print("Successfully loaded \(stemFields.count) STEM fields")
            gameManager.fields = stemFields
        } catch {
            print("Error loading or decoding JSON: \(error)")
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .dataCorrupted(let context):
                    print("Data corrupted: \(context.debugDescription)")
                case .keyNotFound(let key, let context):
                    print("Key not found: \(key.stringValue) - \(context.debugDescription)")
                case .typeMismatch(let type, let context):
                    print("Type mismatch: \(type) - \(context.debugDescription)")
                case .valueNotFound(let type, let context):
                    print("Value not found: \(type) - \(context.debugDescription)")
                @unknown default:
                    print("Unknown decoding error")
                }
            }
        }
    }
}



#Preview {
    GameView().environmentObject(GameManager())
}
