//
//  EditViewController.swift
//  Vaccine
//
//  Created by Felipe Santana on 01/12/20.
//

import UIKit

class EditViewController: UIViewController {

    weak var delegate: ReloadData?
    var coreDataManager = CoreDataManager()
    weak var delegateViewHidden: ViewHidden?

    lazy var editDoseView: EditDoseView = {
        let newView = EditDoseView()
        newView.datePicker.date = vaccineSelected?.orderedDose()[selectedDose!].date ?? Date()
        newView.controller = self
        newView.delegate = self
        return newView
    }()
    
    var selectedDose: Int?
    var vaccineSelected: Vaccine?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        self.view = editDoseView
    }
    
    func editDose(date: Date) {
        let doses = vaccineSelected?.orderedDose()
        doses![selectedDose!].date = date
        coreDataManager.saveContext()
        
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
