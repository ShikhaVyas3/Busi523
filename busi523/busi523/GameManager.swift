//
//  GameManager.swift
//  busi523
//
//  Created by Shikha Vyas on 2/4/25.
//

import Foundation

class GameManager: ObservableObject {
    @Published var currentIndex = 0
    @Published var selectedFields: [(field: StemField, gender: String)] = []
    @Published var showResults = false
}
