//
//  CoreManagerWidget.swift
//  MemoWidget
//
//  Created by 김현석 on 2020/04/16.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import Foundation
import CoreData

class CoreManager {
    static let shared: CoreManager = CoreManager()
    let modelName: String = "Memo"
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
//        let container = NSPersistentContainer(name: "Memo")
        let container = NSCustomPersistentContainer(name: "Memo")
//        print("container : \(container)")
//        let container = NSPersistentContainer.defaultDirectoryURL()
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
//
    func getMemo(ascending:Bool = false) -> [Memo] {
        let context = self.persistentContainer.viewContext
        var models: [Memo] = [Memo]()

        let idSort: NSSortDescriptor = NSSortDescriptor(key: "id", ascending: ascending)
        let fetchRequest: NSFetchRequest<NSManagedObject> = NSFetchRequest<NSManagedObject>(entityName: modelName)
        fetchRequest.sortDescriptors = [idSort]
        do {
            if let fetchResult: [Memo] = try context.fetch(fetchRequest) as? [Memo] {
                print("in fetchResult!")
                models = fetchResult
                print("models len : \(models.count)")
            }else {
                print("else in fetch")
            }
        } catch let error as NSError {
            print("Could not fetch: \(error), \(error.userInfo)")
        }

        return models
    }
}
