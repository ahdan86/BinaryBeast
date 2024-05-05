//
//  LearnCard.swift
//  BinaryGameMenu
//
//  Created by Ahdan Amanullah on 26/04/24.
//

import SwiftUI

struct LearnCard: View {
    var body: some View {
        VStack {
            Image("binaryrow")
                .resizable()
                .frame(width: 232, height: 32)
                .padding(.top, 15)
            HStack(alignment: .bottom) {
                Text("Learn how to read binary numbers").font(
                    .system(
                        size: 13,
                        weight: .semibold,
                        design: .rounded
                    )
                ).foregroundColor(Color.white)
                Spacer()
                NavigationLink{
                   LearnView()
                } label: {
                    ZStack {
                        Circle().fill(Color(hex: "D9D9D9").opacity(0.5))
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .font(Font.body.weight(.bold))
                            .scaleEffect(0.5)
                            .foregroundColor(Color.white)
                    }
                }
                .frame(width: 15, height: 15)
                
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 10)
        }.background(
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "969696"), Color(hex: "848484")]),
                startPoint: .top,
                endPoint: .bottom
            )).clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview{
    LearnCard()
}
