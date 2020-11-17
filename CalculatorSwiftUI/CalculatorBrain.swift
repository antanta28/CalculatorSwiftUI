//
//  CalculatorBrain.swift
//  CalculatorSwiftUI
//
//  Created by Kirill Fedin on 17.11.2020.
//

import Foundation

class CalculatorBrain: ObservableObject {
    public let charArray = ["/", "×", "-", "+", "^"]
    
    @Published var expression: Array<String> = []
    @Published var expressionResult: String = ""
    
    func plusMinusSign() {
        guard expression.count != 0 else { return }
        
        var tempString = ""
        
        for number in expression.reversed() {
            if !charArray.contains(number) {
                tempString = number + tempString
                expression.removeLast()
                
            } else if number == "-" {
                let expressionLenght = expression.count
                
                guard expressionLenght - 1 >= 0 else { break }
                if !expression[expressionLenght - 1].isNumber {
                    tempString = number + tempString
                    expression.removeLast()
                }
                
                break
            } else if number == "+" {
                expression.removeLast()
                break
            } else {
                break
            }
        }
        guard let numberFloat = Float(tempString) else { return }
        
        if numberFloat < 0 && expression.count > 0 {
            expression.append("+")
        }
        let lastNumberString = (-numberFloat).clean
        
        expression += lastNumberString.map({ String($0) })
    }
    
    func buttonTapped(_ button: String) {
        if expressionResult != "" {
            expression = expressionResult.map({ String($0) })
            expressionResult = ""
        }
        
        if button == "=" {
            guard expression.count != 0 else { return }
            guard !charArray.contains(expression.last!) else { return }
            
            calculateWithPriority()
        } else if charArray.contains(button) {
            guard expression.count != 0 else {
                if button == "-" {
                    expression.append(button)
                }
                return
            }
            guard !charArray.contains(expression.last!) else { return }
            
            expression.append(button)
        } else if button == "AC" {
            expression.removeAll()
            
        } else if button == "." {
            guard expression.count != 0 else { return }
            guard expression.last != button else { return }
            
            expression.append(button)
        } else if button == "←" {
            removeLast()
        } else if button == "+/-" {
            plusMinusSign()
        } else {
            guard expression.count < 15 else { return }
            //TODO: Add alert
            expression.append(button)
        }
        print(expression)
    }
    
    func calculateWithPriority() {
        guard expression.count != 0 else { return }
        
        var number = ""
        var calcArray: Array<String> = []
        
        var isLastAction = true
        for element in expression {
            if charArray.contains(element) {
                if isLastAction {
                    number += element
                } else {
                    isLastAction = true
                    
                    calcArray.append(number)
                    calcArray.append(element)
                    number = ""
                }
            } else {
                number += element
                
                isLastAction = false
            }
            
        }
        calcArray.append(number)
        print(calcArray)
        
        func removeFromArray(_ index: Int, action: String) {
            calcArray[index] = performAction(calcArray[index - 1], action, secondNumber: calcArray[index + 1])
            calcArray.remove(at: index + 1)
            calcArray.remove(at: index - 1)
        }
        
        while true {
            guard let indexOfPow = calcArray.firstIndex(of: "^") else { break }
            removeFromArray(indexOfPow, action: "^")
        }

        while true {
            guard let indexOfMultiply = calcArray.firstIndex(of: "×") else {
                guard let indexOfDivision = calcArray.firstIndex(of: "/") else { break }
                removeFromArray(indexOfDivision, action: "/")
                continue
            }
            guard let indexOfDivision = calcArray.firstIndex(of: "/") else {
                guard let indexOfMultiply = calcArray.firstIndex(of: "×") else { break }
                removeFromArray(indexOfMultiply, action: "×")
                continue
            }
            
            if indexOfMultiply < indexOfDivision {
                removeFromArray(indexOfMultiply, action: "×")
            } else {
                removeFromArray(indexOfDivision, action: "/")
            }
        }
        
        for (index, element) in calcArray.enumerated() {
            if ["-", "+"].contains(element) {
                calcArray[index + 1] = performAction(calcArray[index - 1], element, secondNumber: calcArray[index + 1])
            }
        }
        //        print(calcArray)
        guard let result = calcArray.last?.clean else { return }
        expressionResult = result
    }
    
    private func performAction(_ firstNumber: String, _ action: String, secondNumber: String) -> String {
        guard let firstNumber = Float(firstNumber), let secondNumber = Float(secondNumber) else { return "" }
        switch action {
        case "+":
            return String(firstNumber + secondNumber)
        case "-":
            return String(firstNumber - secondNumber)
        case "/":
            return String(firstNumber / secondNumber)
        case "×":
            return String(firstNumber * secondNumber)
        case "^":
            return String(pow(firstNumber, secondNumber))
        default:
            return ""
        }
    }
    
    func removeLast() {
        guard expression.count > 0 else { return }
        
        expression.removeLast()
    }
}
