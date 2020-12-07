//
//  EditViewController.swift
//  Vaccine
//
//  Created by Felipe Santana on 01/12/20.
//

import UIKit

class EditViewController: UIViewController {

    weak var delegate: ReloadData?
    weak var delegateViewHidden: ViewHidden?

    lazy var editDoseView: EditDoseView = {
        let newView = EditDoseView()
        for (index, vaccine) in Person.sharedPerson.vaccines.enumerated() where vaccine.idVaccine == vaccineSelected?.idVaccine {
            newView.datePicker.date = Person.sharedPerson.vaccines[index].dosesTaken[selectedDose ?? 0].date
        }
        newView.controller = self
        newView.delegate = self
        return newView
    }()
    
    var selectedDose: Int?
    var vaccineSelected: VaccineModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        self.view = editDoseView
    }
    
    func editDose(date: Date) {
        for (index, vaccine) in Person.sharedPerson.vaccines.enumerated() where vaccine.idVaccine == vaccineSelected?.idVaccine {
            guard let dose = selectedDose else { return print("Dose nil")}
            Person.sharedPerson.vaccines[index].dosesTaken[dose].date = date
        }
        
        dismissModal()
        delegateViewHidden?.viewHidden()
        delegate?.reloadData()
    }

}

extension EditViewController: DismissModal {
    func dismissModal() {
        self.dismiss(animated: true, completion: nil)
    }
}
