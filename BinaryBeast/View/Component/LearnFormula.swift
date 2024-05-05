//
//  LearnFormula.swift
//  BinaryGameMenu
//
//  Created by Ahdan Amanullah on 29/04/24.
//

import SwiftUI

struct LearnFormula: View {
    var body: some View {
        HStack{
            HStack{
                VStack{
                    Text("1").font(
                        .system(
                            size: 40,
                            weight: .bold,
                            design: .rounded
                        )
                    )
                    Text("2^3").font(
                        .system(
                            size: 12
                        )
                    )
                }
                Text("+")
                VStack{
                    Text("0").font(
                        .system(
                            size: 40,
                            weight: .bold,
                            design: .rounded
                        )
                    )
                    Text("2^2").font(
                        .system(
                            size: 12
                        )
                    )
                    
                }
                Text("+")
                VStack{
                    Text("1").font(
                        .system(
                            size: 40,
                            weight: .bold,
                            design: .rounded
                        )
                    )
                    Text("2^1").font(
                        .system(
                            size: 12
                        )
                    )
                    
                }
                Text("+")
                VStack{
                    Text("0").font(
                        .system(
                            size: 40,
                            weight: .bold,
                            design: .rounded
                        )
                    )
                    Text("2^0").font(
                        .system(
                            size: 12
                        )
                    )
                    
                }
                
            }
            Text("=").font(
                .system(
                    size: 40,
                    weight: .bold,
                    design: .rounded
                )
            )
            Text("10").font(
                .system(
                    size: 40,
                    weight: .medium
                )
            )
            .padding(.all, 20)
            .background(Color(hex: "00A52E"))
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    LearnFormula()
}
