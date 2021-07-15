//
//  Cities+CoreDataProperties.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 15/7/21.
//
//

import Foundation
import CoreData


extension Cities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cities> {
        return NSFetchRequest<Cities>(entityName: "Cities")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: Int16

}

extension Cities : Identifiable {

}
