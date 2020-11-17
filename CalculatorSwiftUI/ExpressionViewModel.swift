//
//  ExpressionViewModel.swift
//  CalculatorSwiftUI
//
//  Created by Kirill Fedin on 18.11.2020.
//

import Foundation

class ExpressionViewModel: ObservableObject {
    @Published var expressions = [Expression]()
    
    init() {
//        NotificationCenter.default.addObserver(self, selector: #selector(expressionAdded), name: Notification.Name(rawValue: "expressionAdded"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(expressionWillBeDeleted), name: Notification.Name(rawValue: "expressionWillBeDeleted"), object: nil)
    }
    
//    @objc func expressionAdded(_ notification: Notification) {
//        guard let expression = notification.object as? Expression else { return }
//        if !expressions.contains(expression) {
//            expressions.append(expression)
//            expressions.sort(by: <)
//        }
//    }
//    @objc func expressionWillBeDeleted(_ notification: Notification) {
//        guard let expression = notification.object as? Expression else { return }
//        if expressions.contains(expression) {
//            let index = expressions.firstIndex(of: expression)!
//            expressions.remove(at: index)
//        }
//    }
    
    func loadExpressions() {
        expressions = Expression.allExtension()
        expressions.sort(by: <)
        print("Expression list loaded. \(expressions.count) expression.")
    }
    
    func deleteAll() {
        Expression.deleteAll()
    }
}
