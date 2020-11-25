//
//  NewDoseViewController.swift
//  Vaccine
//
//  Created by Felipe Santana on 25/11/20.
//

import UIKit

class NewDoseViewController: UIViewController {

    lazy var newDoseView: NewDoseView = {
        let newView = NewDoseView()
        newView.controller = self
        newView.delegate = self
        return newView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        self.view = newDoseView
        
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
