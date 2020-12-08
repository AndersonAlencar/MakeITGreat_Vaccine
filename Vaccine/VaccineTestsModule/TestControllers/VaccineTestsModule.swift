//
//  VaccineTestsModule.swift
//  VaccineTestsModule
//
//  Created by Anderson Alencar on 26/11/20.
//

import XCTest
@testable import Vaccine

class MyCardTests: XCTestCase {

    var person: GeneralManagerModel!
    var generalData: GeneralDataMode!
    var dose: DoseModel!
    var vaccine: VaccineModel!

    override func setUp() {
        person = GeneralManagerModel.sharedPerson
        generalData = GeneralDataMode(idVaccine: 10, nameVaccine: "BCG", prevention: "TomeCuidado", nDoses: 1, indication: "Tomar com moderação", adverseEffects: "Febre", againstIndication: "Proibido para gestantes")
        dose = DoseModel(idDoses: 10, date: Date())
        vaccine = VaccineModel(idVaccine: 10, name: "BCG", nDoses: 2, status: .pending, nextDoses: [1, 2])
    }

    override func tearDown() {
        person = nil
        generalData = nil
        dose = nil
        vaccine = nil
    }

    func testNumberVaccinesPerson() {
        let numberVaccines = 17
        XCTAssertEqual(person.vaccines.count, numberVaccines)
    }

    func testGeneralModel() {
        let vaccineName = "BCG"
        let nDose = 2
        generalData.nDoses = 2
        
        XCTAssertEqual(generalData.nameVaccine, vaccineName)
        XCTAssertEqual(generalData.nDoses, nDose)
    }
    
    func testGenerateDose() {
        let correctID = 10.0
        let currentDate = Date()
        dose.date = currentDate
        XCTAssertEqual(correctID, dose.idDose)
        XCTAssertEqual(currentDate.timeIntervalSince1970, dose.date.timeIntervalSince1970)
    }
    
    func testVaccineStructure() {
        XCTAssertNotNil(vaccine)
    }
    
    func testVaccineEmpty() {
        let dosesTaken = 1
        vaccine.dosesTaken.append(dose)
        XCTAssertEqual(dosesTaken, vaccine.dosesTaken.count)
    }
    
    func testAddVaccine() {
        XCTAssertTrue(vaccine.dosesTaken.isEmpty)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
