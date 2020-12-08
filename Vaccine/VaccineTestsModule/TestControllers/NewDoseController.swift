//
//  NewDoseController.swift
//  VaccineTestsModule
//
//  Created by Anderson Alencar on 07/12/20.
//

import XCTest
import CoreData
@testable import Vaccine

class NewDoseController: XCTestCase {
    
    var doseController: NewDoseViewController?
    var coreDataManager: CoreDataManager?

    override func setUp() {
        doseController = NewDoseViewController()
        coreDataManager = CoreDataManager()
    }
    
    override func tearDown() {
        doseController = nil
        coreDataManager = nil
    }
    
    func testAddDose() {
        let newDate = Date()
        let context = CoreDataManager.persistentContainer.viewContext
        let vaccine = coreDataManager?.fetchVaccines().first
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dose")
        let numberOFDoses = try! context.count(for: fetchRequest)
        doseController?.vaccineSelected = vaccine
        doseController?.addDose(date: newDate)
        let numberOFNewDoses = try! context.count(for: fetchRequest)
        XCTAssertEqual(numberOFDoses + 1, numberOFNewDoses)
    }
    
    func testDelegateDismiss() {
        doseController?.dismissModal()
        XCTAssertNotNil(doseController?.newDoseView.delegate)
    }
    
    func testLoadView() {
        doseController?.loadView()
        XCTAssertNotNil(doseController?.newDoseView)
    }

}
