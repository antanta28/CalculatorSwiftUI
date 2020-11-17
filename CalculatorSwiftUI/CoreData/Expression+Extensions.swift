//
//  Expression.swift
//  CalculatorSwiftUI
//
//  Created by Kirill Fedin on 18.11.2020.
//

import Foundation
import CoreData

extension Expression: Comparable {
    public static func < (lhs: Expression, rhs: Expression) -> Bool {
        lhs.date! < rhs.date!
    }
    
    static func allExtension() -> [Expression] {
        let fetchRequest: NSFetchRequest<Expression> = Expression.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let items = try PersistentStore.shared.context.fetch(fetchRequest)
            return items
        }
        catch let error as NSError {
            print("Error getting User Locations: \(error.localizedDescription), \(error.userInfo)")
        }
        return [Expression]()
    }
    
    static func addNewExpression(expression: String, answer: String) {
        let newExpression = Expression(context: PersistentStore.shared.context)
        newExpression.id = UUID()
        newExpression.date = Date()
        newExpression.answer = answer
        newExpression.expression = expression
        
        Expression.saveChanges()
    }
    
    static func delete(expression: Expression, saveChanges: Bool = false) {
        expression.managedObjectContext?.delete(expression)
        if saveChanges {
            PersistentStore.shared.saveContext()
        }
    }
    
    static func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Expression")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let context = PersistentStore.shared.context
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch _ as NSError {
            // TODO: handle the error
        }
    }

    static func saveChanges() {
        PersistentStore.shared.saveContext()
    }
}
