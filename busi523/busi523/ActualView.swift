//
//  ActualView.swift
//  busi523
//
//  Created by Shikha Vyas on 2/4/25.
//

import SwiftUI

struct ActualView: View {
    @State private var fields: [StemField] = []
    
    private var maleCareers: [StemField] {
        fields.filter { $0.percentMale > $0.percentFemale }
    }
    
    private var femaleCareers: [StemField] {
        fields.filter { $0.percentFemale >= $0.percentMale }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.blue
                    .edgesIgnoringSafeArea(.all)
                
                ScrollView {
                    VStack(spacing: 24) {
                        Text("Actual Statistics")
                            .font(.largeTitle)
                            .fontDesign(.serif)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.top)
                        
                        HStack(alignment: .top, spacing: 16) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Male-Dominated")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)
                                    .underline()
                                ForEach(maleCareers, id: \.name) { field in
                                    Text(field.name)
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Female-Dominated")
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)
                                    .underline()
                                ForEach(femaleCareers, id: \.name) { field in
                                    Text(field.name)
                                        .padding(5)
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        
                        Spacer()
                    }
                    .padding()
                }
            }
        }
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
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([String: [StemField]].self, from: data)
            
            guard let stemFields = jsonData["stemFields"] else {
                print("No 'stemFields' key found in JSON")
                return
            }
            
            print("Successfully loaded \(stemFields.count) STEM fields")
            fields = stemFields
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    }
}

#Preview {
    ActualView()
}

