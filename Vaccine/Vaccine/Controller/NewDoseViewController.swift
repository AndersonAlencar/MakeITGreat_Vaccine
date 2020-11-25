//
//  NewDoseViewController.swift
//  Vaccine
//
//  Created by Felipe Santana on 25/11/20.
//

import UIKit

class NewDoseViewController: UIViewController {
    
    weak var delegate: ReloadData?

    lazy var newDoseView: NewDoseView = {
        let newView = NewDoseView()
        newView.controller = self
        newView.delegate = self
        return newView
    }()
    
    var vaccineSelected: VaccineModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        self.view = newDoseView
        
    }
    
    func addDose(date: Date) {
        for (index, vaccine) in Person.sharedPerson.vaccines.enumerated() {
            if vaccine.idVaccine == vaccineSelected?.idVaccine {
                let dose = DoseModel(idDoses: 0, date: date)
                Person.sharedPerson.vaccines[index].dosesTaken.append(dose)
            }
        }
        
        dismissModal()
        delegate?.reloadData()
    }

}

protocol DismissModal: class {
    func dismissModal()
}

extension NewDoseViewController: DismissModal {
    func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
}
