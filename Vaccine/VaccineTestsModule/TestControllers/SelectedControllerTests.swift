//
//  SelectedControllerTests.swift
//  VaccineTestsModule
//
//  Created by Anderson Alencar on 07/12/20.
//

import XCTest
import UIKit
@testable import Vaccine

class SelectedControllerTests: XCTestCase {

    var selectedController: SelectedVaccineViewController?
    var coreDataManager: CoreDataManager?
    var navigationController: UINavigationController?

    override func setUp() {
        selectedController = SelectedVaccineViewController()
        coreDataManager = CoreDataManager()
        navigationController = UINavigationController(rootViewController: selectedController!)
    }
    
    override func tearDown() {
        selectedController = nil
        coreDataManager = nil
        navigationController = nil
        
    }
    
    func testColoBar() {
        selectedController?.changeColorBar()
        let constains = selectedController?.navigationController?.navigationBar.subviews.contains(selectedController!.colorView)
        XCTAssertTrue(constains ?? false)
    }
    
    func testWillApperarNavigation() {
        selectedController?.viewWillAppear(true)
        XCTAssertNotNil(selectedController?.navigationController)
    }
    
    func testInformationAction() {
        selectedController?.informationAction()
        if let topItem = navigationController?.topViewController as? GeneralInformationViewController {
            XCTFail("Falha ao typecast da vavigation \(topItem)")
        } else {
            XCTAssertTrue(true)
        }
    }
    
    func testDeleteDose() {
        let vaccine = coreDataManager?.fetchVaccines().first
        let context = CoreDataManager.persistentContainer.viewContext
//        let numberOfDoses = vaccine?.orderedDose().count
        
        let newDose = Dose(context: context)
        newDose.date = Date()
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        vaccine?.addToDose(newDose)
        coreDataManager?.saveContext()
        
        let action = selectedController?.deleteAction(at: indexPath)
//        let newNumberDoses = coreDataManager?.fetchVaccines().first?.orderedDose().count
        XCTAssertNotNil(action)
    }
    
    func testView() {
        XCTAssertNotNil(selectedController?.selectedView)
    }
    
    func testDidLoadNavigation() {
        let vaccine = coreDataManager?.fetchVaccines().first
        selectedController?.vaccineSelected = vaccine
        selectedController?.viewDidLoad()
        XCTAssertEqual(selectedController?.navigationItem.title, selectedController?.vaccineSelected?.name)
    }
    
    func testADD() {
        selectedController?.add()
        if (navigationController?.topViewController as? SelectedVaccineViewController) != nil {
            XCTAssertTrue(true)
        } else {
            XCTFail("Falha ao typecast da navigation")
        }
    }
    
    func testEdit() {
        selectedController?.edit(dose: 0)
        if navigationController?.topViewController is SelectedVaccineViewController {
            XCTAssertTrue(true)
        } else {
            XCTFail("Falha ao typecast da navigation")
        }
    }
    
    func testReload() {
        XCTAssertNotNil(selectedController?.selectedView.tableView)
        selectedController?.reloadData()
    }
    
    func testViewHidden() {
        selectedController?.viewHidden()
        XCTAssertTrue(((selectedController?.selectedView.isHidden) != nil))
    }
    
    func testTableView() {
        let vaccine = coreDataManager?.fetchVaccines().first
        selectedController?.vaccineSelected = vaccine
        let tableView = selectedController?.selectedView.tableView
        
        var indexPath = IndexPath(row: 0, section: 0)
        let cell = (tableView?.dataSource?.tableView(tableView!, cellForRowAt: indexPath))! as! DoseTableViewCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        
        let doseDate = formatter.string(from: selectedController?.vaccineSelected?.orderedDose()[indexPath.row].date ?? Date())

        XCTAssertEqual(doseDate, formatter.string(from: Date()))
        XCTAssertEqual(vaccine?.orderedDose().count, tableView?.dataSource?.tableView(tableView!, numberOfRowsInSection: 0))
        XCTAssertNotNil(cell)

        indexPath = IndexPath(row: 0, section: 1)
        let cell2 = (tableView?.dataSource?.tableView(tableView!, cellForRowAt: indexPath))! as! WarningDoseTableViewCell
        XCTAssertEqual(cell2.warningText.text, "Sempre leve o seu cartão de vacinação para registrar as doses. Esse aplicativo não substitui orientação médica.")
        XCTAssertNotNil(cell2)
    }
    
    func testEmptyStage() {
        let vaccine = coreDataManager?.fetchVaccines()[1]
        selectedController?.vaccineSelected = vaccine
        let tableView = selectedController?.selectedView.tableView
        
        let empty = selectedController?.tableView(tableView!, numberOfRowsInSection: 0)
        XCTAssertNotNil(empty)
    }
    
}
