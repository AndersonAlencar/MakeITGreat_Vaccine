//
//  MyCardController.swift
//  VaccineTestsModule
//
//  Created by Anderson Alencar on 27/11/20.
//

import XCTest
@testable import Vaccine

class MyCardController: XCTestCase {

    var myCardController: MyCardViewController!
    
    var selectedVaccineView: SelectedVaccineView!
    
    override func setUp() {
        myCardController = MyCardViewController()
        selectedVaccineView = SelectedVaccineView()
    }
    
    override func tearDown() {
        myCardController = nil
        selectedVaccineView = nil
    }

    func testNumberVaccinesPerson() {
        myCardController.updateSearchResults(for: myCardController.searchController)
        XCTAssertEqual(myCardController.filteredData.count, 17)
    }
    
    func testDelegateAddDose() {
        let controller = SelectedVaccineViewController()
        selectedVaccineView.delegate = controller
        controller.add()
        controller.doses.co
    }

}
