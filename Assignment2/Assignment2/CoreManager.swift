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
    
//    static let shared: CoreDataManager = CoreDataManager()
//
//    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
//    lazy var context = appDelegate?.persistentContainer.viewContext
//
//    let modelName: String = "Users"
    
    func getMemo(ascending:Bool = false) -> [Memo] {
        var models: [Memo] = [Memo]()
        
        if let context = context {
            let idSort: NSSortDescriptor = NSSortDescriptor(key: "title", ascending: ascending)
            let fetchRequest: NSFetchRequest<NSManagedObject>
                = NSFetchRequest<NSManagedObject>(entityName: modelName)
            fetchRequest.sortDescriptors = [idSort]
            
            do {
                if let fetchResult: [Memo] = try context.fetch(fetchRequest) as? [Memo] {
                    models = fetchResult
                }
            } catch let error as NSError {
                print("Could not fetch🥺: \(error), \(error.userInfo)")
            }
        }
        return models
    }
    
    func saveMemo(title: String, content: String, onSuccess: @escaping ((Bool) -> Void)) {
        if let context = context,
            let entity: NSEntityDescription
            = NSEntityDescription.entity(forEntityName: modelName, in: context) {
            
            if let memo: Memo = NSManagedObject(entity: entity, insertInto: context) as? Memo {                
                memo.title = title
                memo.content = content
                contextSave { success in
                    onSuccess(success)
                }
            }
        }
    }
}

extension CoreManager {
//    fileprivate func filteredRequest(id: Int64) -> NSFetchRequest<NSFetchRequestResult> {
//        let fetchRequest: NSFetchRequest<NSFetchRequestResult>
//            = NSFetchRequest<NSFetchRequestResult>(entityName: modelName)
//        fetchRequest.predicate = NSPredicate(format: "id = %@", NSNumber(value: id))
//        return fetchRequest
//    }
    
    fileprivate func contextSave(onSuccess: ((Bool) -> Void)) {
        do {
            try context?.save()
            onSuccess(true)
        } catch let error as NSError {
            print("Could not save🥶: \(error), \(error.userInfo)")
            onSuccess(false)
        }
    }
}
