//
//  Persistence.swift
//  Devote
//
//  Created by Łukasz Klimkiewicz on 17/09/2021.
//

import CoreData

struct PersistenceController {
    
    // MARK: - PRESISTENT CONTROLLER
    
    static let shared = PersistenceController()

    
    // MARK: - PERSISTENT CONTAINER
    
    let container: NSPersistentContainer

    
    // MARK: - INITIALIZATION (load the persistent store)
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Devote")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // MARK: - PREVIEW
    
    static var preview: PersistenceController = {
        
        let result = PersistenceController(inMemory: true)
        
        let viewContent = result.container.viewContext
        
//        for i in 0 ..< 5 {
//            
//            let newItem = Item(context: viewContent)
//            newItem.timestamp = Date()
//            newItem.task = "Sample task No\(i)"
//            newItem.completion = false
//            newItem.id = UUID()
//            
//        }
        
        do {
            
            try viewContent.save()
            
        } catch {
            
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                        
        }
        
        return result
        
    }()
}
 
