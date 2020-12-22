//
//  ContentView.swift
//  SliderGame
//
//  Created by Никита Гвоздиков on 21.12.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentValue: Double = 50
    @State private var targetValue = Int.random(in: 0...100)
    @State private var showAlert = false
    @State private var opacity: CGFloat = 1
    
    
    var body: some View {
        VStack {
            Text("Подвиньте слайдер, как можно ближе к: \(targetValue)")
                .font(.subheadline)
            
            HStack {
                Text("0")
                SliderUIKit(value: $currentValue,
                            alpha: $opacity) {
                    setValueForOpacity()
                }
                
                Text("100")
            }.padding()
            
            Button("Проверь меня!") {
                showAlert = true
                
            }.padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Your Score"),
                      message: Text("\(computeScore())"))
            }
            
            Button("Начать заново") {
                targetValue = Int.random(in: 0...100)
                setValueForOpacity()
            }
        }
    }
    
    private func setValueForOpacity() {
        opacity = CGFloat(Double(computeScore()) / 100)
    }
    
    private func computeScore() -> Int {
        let difference = abs(targetValue - lround(currentValue))
        return 100 - difference
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
