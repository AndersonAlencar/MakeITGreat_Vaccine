//
//  GeneralInformationControllerTest.swift
//  VaccineTestsModule
//
//  Created by Anderson Alencar on 07/12/20.
//

import XCTest
import CoreData
@testable import Vaccine

class GeneralInformationControllerTest: XCTestCase {

    var generalController: GeneralInformationViewController?
    var coreDataManager: CoreDataManager?
    var navigationController: UINavigationController?

    override func setUp() {
        generalController = GeneralInformationViewController()
        coreDataManager = CoreDataManager()
        navigationController = UINavigationController(rootViewController: generalController!)
    }
    
    override func tearDown() {
        generalController = nil
        coreDataManager = nil
        navigationController = nil
    }
    
    func testDidLoadSetUo() {
        generalController?.viewDidLoad()
        XCTAssertEqual(generalController?.navigationController?.navigationBar.tintColor, .purpleAction)
    }
    
    func testCloseButton() {
        generalController?.closeButtonAction()
        XCTAssertNotNil(generalController?.navigationController)
    }
    
    func testTable() {
        let vaccine = coreDataManager?.fetchVaccines().first
        generalController?.vaccineSelected = vaccine
        let table = generalController?.generalInformationView.informationTableView

        var indexPath = IndexPath(row: 0, section: 0)
        let cell = (table?.dataSource?.tableView(table!, cellForRowAt: indexPath))! as! GeneralDataTableViewCell

        XCTAssertEqual(cell.titleLabel.text, "Dados Gerais")
        XCTAssertEqual(2, table?.dataSource?.tableView(table!, numberOfRowsInSection: 0))
        XCTAssertNotNil(cell)
        
        indexPath = IndexPath(row: 1, section: 0)
        let cell2 = (table?.dataSource?.tableView(table!, cellForRowAt: indexPath))! as! AboutVaccineTableViewCell
        XCTAssertEqual(cell2.titleLabel.text, "Sobre a Vacina")
        XCTAssertNotNil(cell2)
    }
    
    func testGeneralView() {
        generalController?.generalInformationView.layoutSubviews()
        XCTAssertTrue(((generalController?.generalInformationView.subviews.contains((generalController?.generalInformationView.informationTableView)!)) != nil))
    }

}
