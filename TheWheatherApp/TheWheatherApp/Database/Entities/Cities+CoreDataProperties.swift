//
//  Cities+CoreDataProperties.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 16/7/21.
//
//

import Foundation
import CoreData


extension Cities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cities> {
        return NSFetchRequest<Cities>(entityName: "Cities")
    }

    @NSManaged public var name: String?
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var country: String?

}

extension Cities : Identifiable {

}
