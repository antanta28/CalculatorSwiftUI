//
//  CalculatorView.swift
//  CalculatorSwiftUI
//
//  Created by Kirill Fedin on 14.11.2020.
//

// TODO: Добавить сохранение решений

import SwiftUI

struct CalculatorView: View {
    @Environment(\.colorScheme) var colorScheme
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @StateObject var calcBrain = CalculatorBrain()
    
    private let buttons = [
        "AC", "+/-", "^", "/",
        "7", "8", "9", "×",
        "4", "5", "6", "-",
        "1", "2", "3", "+",
        ".", "0", "←", "="
    ]
    
    private func joinExpression(expression: Array<String>) -> String {
        var result = ""
        for sym in expression {
            if calcBrain.charArray.contains(sym) {
                result += " " + sym + " "
            } else {
                result += sym
            }
        }
        return result
    }
    
    private func getColor(_ button: String) -> Color {
        switch button {
        case "/", "-", "+", "×":
            return colorScheme == .dark ? Color.gray.opacity(0.4) : Color.gray.opacity(0.1)
        case "=":
            return Color.newPurple
        default:
            return Color.clear
        }
    }
    
    private func getForegroundColor(_ button: String) -> Color {
        switch button {
        case "=":
            return Color.white
        default:
            return colorScheme == .dark ? Color.white : Color.black
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                HStack {
                    Spacer(minLength: 0)
                    
                    if calcBrain.expressionResult != "" {
                        Text(calcBrain.expressionResult)
                            .multilineTextAlignment(.trailing)
                            .font(.system(size: 80))
                    }
                }
                .padding(.bottom, 20)
                HStack {
                    Spacer(minLength: 0)
                    Text(joinExpression(expression: calcBrain.expression))
                        .font(.system(size: 50))
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(Color.newPurple)
                        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onEnded({ (value) in
                            if value.translation.width < 0 {
                                if calcBrain.expressionResult == "" {
                                    calcBrain.removeLast()
                                }
                            }
                        }))
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(buttons, id: \.self) { button in
                    Button(action: {
                        calcBrain.buttonTapped(button)
                    }) {
                        Text(button)
                            .bold()
                            .frame(width: UIScreen.main.bounds.width / 6, height: UIScreen.main.bounds.width / 6)
                            .contentShape(Rectangle())
                    }
                    .background(getColor(button))
                    .foregroundColor(getForegroundColor(button))
                    .cornerRadius(100)
                }
                
            }
        }
        
        .background(colorScheme == .dark ? Color.black.ignoresSafeArea() : Color.white.ignoresSafeArea())
        
    }
}

struct CalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
    }
}
