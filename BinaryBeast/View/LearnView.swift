//
//  LearnView.swift
//  BinaryGameMenu
//
//  Created by Ahdan Amanullah on 29/04/24.
//

import SwiftUI

struct LearnView: View {
    @Environment(\.dismiss) var dismiss
    @State private var result = 0
    @State private var binaryNumbers: [Bool] = [false, false, false, false]
    @State private var isPressed: [Bool] = [false, false, false, false]
    
    func binaryToDecimal() -> Int {
        var decimalNumber = 0
        
        for (index, state) in binaryNumbers.enumerated() {
            if state {
                decimalNumber += Int(pow(2, Double(binaryNumbers.count - index - 1)))
            }
        }
        
        return decimalNumber
    }
    
    var body: some View {
        VStack{
            LearnFormula().padding(.bottom, 10)
            let text1 = try! AttributedString(markdown: "Imagine you have a light switch. It can either be on or off, right? In binary, we use these \"on\" and \"off\" states to represent numbers. Instead of using the normal base 10 system (where we have 10 digits: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9), we only use **0**s and **1**s in binary.")
            Text(text1).padding(.bottom, 10).fontWeight(.light)
            let text2 = try! AttributedString(markdown: "Each digit in a binary number represents a power of 2, just like in our regular number system each digit represents a power of 10. For example, in the number 1010, the first 1 represents 8 (which is 2 raised to the power of 3), the second 0 represents 4 (2 raised to the power of 2), the third 1 represents 2 (2 raised to the power of 1), and the last 0 represents 0 (2 raised to the power of 0). So, **8+0+2+0 = 10**")
            Text(text2).padding(.bottom, 10).fontWeight(.light)
            HStack {
                Text("Try it Yourself").font(
                    .system(
                        size: 24,
                        weight: .medium,
                        design: .rounded
                    )
                )
                Spacer()
            }
            VStack{
                Text(String(result)).font(
                    .system(
                        size: 40,
                        weight: .medium
                    )
                )
                .frame(width: 80, height: 80)
                .background(Color(hex: "00A52E"))
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.bottom, 16)
                HStack {
                    ForEach(0 ..< 4) { index in
                        Button(action: {
                            binaryNumbers[index] = !binaryNumbers[index]
                            result = binaryToDecimal()
                        }) {
                            if(isPressed[index]){
                                Image(binaryNumbers[index] ? "button1pressed" : "button0pressed")
                                    .resizable()
                                    .frame(width: 80, height: 70)
                            }
                            else{
                                Image(binaryNumbers[index] ? "button1idle" : "button0idle")
                                    .resizable()
                                    .frame(width: 80, height: 70)
                            }
                            
                        }
                        .buttonStyle(.plain)
                        .pressAction{
                            isPressed[index] = true
                        } onRelease: {
                            isPressed[index] = false
                        }
                    }
                }
                Text("Try to change the binary numbers above !").font(
                    .system(
                        size: 14,
                        weight: .bold,
                        design: .rounded
                    )
                )
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .navigationTitle("Learn")
        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .topBarLeading) {
//                Button(action: {
//                    dismiss()
//                }) {
//                    HStack {
//                        Label("Main Menu", systemImage: "arrow.left.circle")
//                        Text("Main Menu")
//                    }
//                }
//            }
//        }
    }
}

#Preview {
    LearnView()
}
