//
//  MyCardControllerTests.swift
//  VaccineTestsModule
//
//  Created by Anderson Alencar on 07/12/20.
//

import XCTest
@testable import Vaccine


class MyCardControllerTests: XCTestCase {

    var myCardController: MyCardViewController?
    var coreDataManager: CoreDataManager?

    override func setUp() {
        myCardController = MyCardViewController()
        coreDataManager = CoreDataManager()
    }
    
    override func tearDown() {
        myCardController = nil
        coreDataManager = nil
    }
    
    func testSearch() {
        myCardController?.searchController.searchBar.text = "polio"
        XCTAssertEqual(myCardController?.searchController.searchBar.text, "polio")
        myCardController?.updateSearchResults(for: myCardController!.searchController)
        XCTAssertEqual(2, myCardController?.filteredData?.count)
    }

}
