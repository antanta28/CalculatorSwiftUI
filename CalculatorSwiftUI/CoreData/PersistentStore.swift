//
//  Persistence.swift
//  CalculatorSwiftUI
//
//  Created by Kirill Fedin on 14.11.2020.
//

import CoreData

final class PersistentStore {
    
    private(set) static var shared = PersistentStore()

    private init() { }
        
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "CalculatorSwiftUI")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
 
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
        })
        return container
    }()
    
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
            }
        }
    }
}
