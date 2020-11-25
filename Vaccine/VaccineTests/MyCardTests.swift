//
//  MyCardTests.swift
//  VaccineTests
//
//  Created by Anderson Alencar on 25/11/20.
//

import XCTest
@testable import Vaccine

class MyCardTests: XCTestCase {

    var person: Person!
    
    override func setUp() {
        person = Person.sharedPerson
    }
    
    override func tearDown() {
        person = nil
    }

    func testNumberVaccinesPerson() {
        let numberVaccines = 17
        XCTAssertEqual(person.vaccines.count, numberVaccines)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
