//
//  MainCard.swift
//  BinaryGameMenu
//
//  Created by Ahdan Amanullah on 26/04/24.
//

import SwiftUI

struct MainCard: View {
    @State var startValue = -5.0
    
    var body: some View{
        ZStack(alignment: .bottom){
            Image("monster1static")
                .resizable()
                .frame(width: 100, height: 114)
                .padding(.vertical, 20)
                .offset(y: startValue)
                .onAppear{
                    let baseAnimation = Animation.easeInOut(duration: 1)
                    let repeated = baseAnimation.repeatForever(autoreverses: true)
                    
                    withAnimation(repeated) {
                        startValue = 5.0
                    }
                }
            HStack(alignment: .bottom) {
                VStack(alignment: .leading){
                    Text("Last Play").font(
                        .system(
                            size: 24,
                            weight: .bold,
                            design: .rounded
                        )
                    ).foregroundColor(Color.white)
                    HStack{
                        Text("Level 1").font(
                            .system(
                                size: 16,
                                weight: .regular,
                                design: .rounded
                            )
                        ).foregroundColor(Color.white)
                        Text("•").foregroundColor(Color.white)
                        Text("Time N/A").font(
                            .system(
                                size: 16,
                                weight: .regular,
                                design: .rounded
                            )
                        ).foregroundColor(Color.white)
                    }
                }
                Spacer()
                NavigationLink {
                   GameView()
                } label: {
                    Text("Play").font(
                        .system(
                            size: 16,
                            weight: .bold,
                            design: .rounded
                        )
                    )
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Color(hex: "D9D9D9").opacity(0.35)
                    )
                    .foregroundColor(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }.background(
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "6AE7E8"), Color(hex: "54B9BB")]),
                startPoint: .top,
                endPoint: .bottom
            ))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    MainCard()
}
