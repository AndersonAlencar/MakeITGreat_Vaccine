//
//  NewDoseViewController.swift
//  Vaccine
//
//  Created by Felipe Santana on 25/11/20.
//

import UIKit
import CoreData

class NewDoseViewController: UIViewController {
    
    weak var delegate: ReloadData?
    
    let coreDataManager = CoreDataManager()
    weak var delegateViewHidden: ViewHidden?

    lazy var newDoseView: NewDoseView = {
        let newView = NewDoseView()
        newView.controller = self
        newView.delegate = self
        return newView
    }()
    
    var vaccineSelected: Vaccine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = newDoseView
        
    }
    
    func addDose(date: Date) {
        let newDose = Dose(context: CoreDataManager.persistentContainer.viewContext)
        newDose.date = date
        //newDose.idDose = 1
        vaccineSelected?.addToDose(newDose)
        coreDataManager.saveContext()
        
        dismissModal()
        delegate?.reloadData()
        delegateViewHidden?.viewHidden()
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
