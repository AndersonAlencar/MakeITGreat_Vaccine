//
//  EditControllerTests.swift
//  VaccineTestsModule
//
//  Created by Anderson Alencar on 07/12/20.
//

import XCTest
@testable import Vaccine

class EditControllerTests: XCTestCase {

    var editController: EditViewController?
    var coreDataManager: CoreDataManager?

    override func setUp() {
        editController = EditViewController()
        coreDataManager = CoreDataManager()
    }
    
    override func tearDown() {
        editController = nil
        coreDataManager = nil
    }
    
    func testEditDose() {
        let newDate = Date()
        let context = CoreDataManager.persistentContainer.viewContext
        var vaccine = coreDataManager?.fetchVaccines().first
        let dose = Dose(context: context)
        dose.date = newDate
        vaccine?.addToDose(dose)
        
        editController?.vaccineSelected = vaccine
        editController?.selectedDose = 0
        editController?.editDose(date: newDate)
        
        vaccine = coreDataManager?.fetchVaccines().first
        XCTAssertTrue(((vaccine?.orderedDose().contains(dose)) != nil))
    }
    
    func testDelegateDismiss() {
        editController?.dismissModal()
        XCTAssertNotNil(editController?.editDoseView)
    }
}
