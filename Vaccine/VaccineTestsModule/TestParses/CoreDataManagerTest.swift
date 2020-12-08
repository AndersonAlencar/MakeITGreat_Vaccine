//
//  CoreDataManagerTest.swift
//  VaccineTestsModule
//
//  Created by Anderson Alencar on 07/12/20.
//

import XCTest
import CoreData
@testable import Vaccine

class CoreDataManagerTest: XCTestCase {

    var coreDataManager: CoreDataManager?

    override func setUp() {
        coreDataManager = CoreDataManager()
    }

    override func tearDown() {
        coreDataManager = nil
    }
    
    func testFetchUSer() {
        let user = coreDataManager?.getUser()
        XCTAssertNotNil(user)
    }
    
    func testFetchVaccine() {
        let context = CoreDataManager.persistentContainer.viewContext
        let vaccines = try! context.fetch(Vaccine.fetchRequest())
        XCTAssertEqual(17, vaccines.count)
        
        let parameter: NSFetchRequest<Vaccine> = Vaccine.fetchRequest()
        print(parameter)
    }
    
    func testFetchDose() {
        let context = CoreDataManager.persistentContainer.viewContext
        let doses = try! context.fetch(Dose.fetchRequest())
        let parameter: NSFetchRequest<Dose> = Dose.fetchRequest()
        XCTAssertNotNil(parameter)
    }
    
    func testUser() {
        let parameter: NSFetchRequest<User> = User.fetchRequest()
        XCTAssertNotNil(parameter)
    }

}
