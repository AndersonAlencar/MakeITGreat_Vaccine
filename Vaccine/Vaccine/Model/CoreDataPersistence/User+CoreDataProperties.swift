//
//  User+CoreDataProperties.swift
//  Vaccine
//
//  Created by Anderson Alencar on 03/12/20.
//
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var vaccines: NSSet?

}

// MARK: Generated accessors for vaccines
extension User {

    @objc(addVaccinesObject:)
    @NSManaged public func addToVaccines(_ value: Vaccine)

    @objc(removeVaccinesObject:)
    @NSManaged public func removeFromVaccines(_ value: Vaccine)

    @objc(addVaccines:)
    @NSManaged public func addToVaccines(_ values: NSSet)

    @objc(removeVaccines:)
    @NSManaged public func removeFromVaccines(_ values: NSSet)

}

extension User: Identifiable {

}
