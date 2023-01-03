//
//  Diary+CoreDataProperties.swift
//  Diary
//
//  Created by jin on 1/3/23.
//
//

import Foundation
import CoreData


extension Diary {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Diary> {
        return NSFetchRequest<Diary>(entityName: "Diary")
    }

    @NSManaged public var createdAt: Double
    @NSManaged public var id: UUID
    @NSManaged public var text: String
    @NSManaged public var icon: String?

}

extension Diary : Identifiable {

}
