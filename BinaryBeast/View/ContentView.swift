//
//  ContentView.swift
//  BinaryGameMenu
//
//  Created by Ahdan Amanullah on 26/04/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    
    @Query private var levelsData: [LevelData]
    private var levels: [Int] = Array(1...5)
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                NavigationLink(destination: GameView()) {
                    MainCard()
                }.padding(.top, 16)
                NavigationLink(destination: LearnView()) {
                    LearnCard()
                }
                Text("Levels")
                    .font(
                        .system(
                            size: 24,
                            weight: .medium,
                            design: .rounded
                        )
                    )
                LazyVGrid(columns: adaptiveColumns, spacing: 10){
                    ForEach(levels, id:\.self) { number in
                        LevelCard(levelNumber: number, bestScore: nil)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .navigationTitle("Binary Beast")
        }
    }
}

#Preview {
    ContentView()
}
