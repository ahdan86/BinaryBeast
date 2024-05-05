//
//  LevelCard.swift
//  BinaryGameMenu
//
//  Created by Ahdan Amanullah on 29/04/24.
//

import SwiftUI

struct LevelCard: View {
    @State var startValue = -5.0
    var levelNumber: Int
    var bestScore: Int?
    
    func formatSecondsToMinutes(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    var body: some View {
        ZStack(alignment: .bottom){
            Image("monster\(levelNumber)static")
                .resizable()
                .frame(width: 80, height: 90)
                .padding(.vertical, 20)
            HStack(alignment: .bottom){
                VStack(alignment:.leading){
                    Text("Level \(levelNumber)").font(
                        .system(
                            size: 16,
                            weight: .bold,
                            design: .rounded
                        )
                    ).foregroundColor(Color.white)
                    if bestScore != nil {
                        Text("Best Time \(formatSecondsToMinutes(seconds: bestScore!))").font(
                            .system(
                                size: 12,
                                weight: .regular,
                                design: .rounded
                            )
                        ).foregroundColor(Color.white)
                    }
                }
                Spacer()
                Button(action: {
                    
                }) {
                    ZStack {
                        Circle().fill(Color(hex: "D9D9D9").opacity(0.5))
                        Image(systemName: "lock.fill")
                            .resizable()
                            .scaledToFit()
                            .font(Font.body.weight(.bold))
                            .scaleEffect(0.5)
                            .foregroundColor(Color.white)
                    }
                }.frame(width: 30, height: 30)
            }.padding(.horizontal, 12)
            .padding(.bottom ,10)
        }.frame(width:167, height: 122)
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    LevelCard(levelNumber: 1, bestScore: 100)
}
