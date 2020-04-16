//
//  Memo+CoreDataProperties.swift
//  Assignment2
//
//  Created by 김현석 on 2020/04/16.
//  Copyright © 2020 urbanGY. All rights reserved.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var content: String?
    @NSManaged public var title: String?
    @NSManaged public var id: Int64

}
