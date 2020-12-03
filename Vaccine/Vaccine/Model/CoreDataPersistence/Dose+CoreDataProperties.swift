//
//  Dose+CoreDataProperties.swift
//  Vaccine
//
//  Created by Anderson Alencar on 03/12/20.
//
//

import Foundation
import CoreData

extension Dose {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dose> {
        return NSFetchRequest<Dose>(entityName: "Dose")
    }

    @NSManaged public var date: Date?
    @NSManaged public var idDose: Double
    @NSManaged public var vaccine: Vaccine?

}

extension Dose: Identifiable {

}
