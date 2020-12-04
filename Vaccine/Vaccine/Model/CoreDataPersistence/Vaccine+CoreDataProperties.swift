//
//  Vaccine+CoreDataProperties.swift
//  Vaccine
//
//  Created by Anderson Alencar on 03/12/20.
//
//

import Foundation
import CoreData

extension Vaccine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vaccine> {
        return NSFetchRequest<Vaccine>(entityName: "Vaccine")
    }

    @NSManaged public var idVaccine: Double
    @NSManaged public var name: String?
    @NSManaged public var nDoses: Int64
    @NSManaged public var nextDosesByMonth: Int64
    @NSManaged public var vaccineStatus: Int64
    @NSManaged public var dose: NSSet?
    @NSManaged public var user: User?

}

// MARK: Generated accessors for dose
extension Vaccine {

    @objc(addDoseObject:)
    @NSManaged public func addToDose(_ value: Dose)

    @objc(removeDoseObject:)
    @NSManaged public func removeFromDose(_ value: Dose)

    @objc(addDose:)
    @NSManaged public func addToDose(_ values: NSSet)

    @objc(removeDose:)
    @NSManaged public func removeFromDose(_ values: NSSet)

}

extension Vaccine: Identifiable {

}

extension Vaccine {
    func orderedDose() -> [Dose] {
        let doseSet = self.dose as! Set<Dose>
        let doseArray = doseSet.sorted(by: { (dose1, dose2) -> Bool in
            dose1.date! < dose2.date!
        })
        return doseArray
    }
}
