//
//  CoreManager.swift
//  Assignment2
//
//  Created by 김현석 on 2020/04/11.
//  Copyright © 2020 urbanGY. All rights reserved.
//
import UIKit
import CoreData

class CoreManager {
    static let shared: CoreManager = CoreManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    let modelName: String = "Memo"
        
    func getMemo(ascending:Bool = false) -> [Memo] {
        var models: [Memo] = [Memo]()
        
        if let context = context {
            let idSort: NSSortDescriptor = NSSortDescriptor(key: "id", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject>
                = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [idSort]
            
            do {
                if let fetchResult: [Memo] = try context.fetch(fetchRequest) as? [Memo] {
                    models = fetchResult
                    print("in app models length : \(models.count)")
                }
            } catch let error as NSError {
                print("Could not fetch: \(error), \(error.userInfo)")
            }
        }
        return models
    }
    
    func saveMemo(id:Int64, title: String, content: String, onSuccess: @escaping ((Bool) -> Void)) {
        if let context = context,
            let entity: NSEntityDescription
            = NSEntityDescription.entity(forEntityName: modelName, in: context) {
            
            if let memo: Memo = NSManagedObject(entity: entity, insertInto: context) as? Memo {
                memo.id = id
                memo.title = title
                memo.content = content
                contextSave { success in
                    onSuccess(success)
                }
            }
        }
    }
    
    func deleteMemo(title: String , onSuccess: @escaping ((Bool) -> Void)) {
        let fetchRequest: NSFetchRequest<NSManagedObject> = filteredRequest()
                
        do {
            if let results: [Memo] = try context?.fetch(fetchRequest) as? [Memo] {
                if results.count != 0 {
                    for elem in results {
                        if elem.title == title {
                            context?.delete(elem)
                        }
                    }
                }
            }
        } catch let error as NSError {
            print("Could not fatch: \(error), \(error.userInfo)")
            onSuccess(false)
        }
        
        contextSave { success in
            onSuccess(success)
        }
    }
    
    func deleteMemoNSPredicate(title: String , onSuccess: @escaping ((Bool) -> Void)) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = filteredRequestNSPredicate(title)
        
        do {
            if let results: [Memo] = try context?.fetch(fetchRequest) as? [Memo] {
                if results.count != 0 {
                    context?.delete(results[0])
                }
            }
        } catch let error as NSError {
            print("Could not fatch: \(error), \(error.userInfo)")
            onSuccess(false)
        }
        
        contextSave { success in
            onSuccess(success)
        }
    }

}

extension CoreManager {
    fileprivate func filteredRequest() -> NSFetchRequest<NSManagedObject> {
        let idSort: NSSortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        let fetchRequest: NSFetchRequest<NSManagedObject>
            = NSFetchRequest<NSManagedObject>(entityName: modelName)
        fetchRequest.sortDescriptors = [idSort]
        return fetchRequest
    }
    
    fileprivate func filteredRequestNSPredicate(_ title: String) -> NSFetchRequest<NSFetchRequestResult> {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
            = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
        fetchRequest.predicate = NSPredicate(format: "title = %@", NSString(string: title))
        return fetchRequest
    }
    
    fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
        do {
            try context?.save()
            onSuccess(true)
        } catch let error as NSError {
            print("Could not save: \(error), \(error.userInfo)")
            onSuccess(false)
        }
    }
}
