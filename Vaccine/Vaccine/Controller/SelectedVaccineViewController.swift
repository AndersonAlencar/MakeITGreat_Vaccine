//
//  SelectedVaccineViewController.swift
//  Vaccine
//
//  Created by Helaine Pontes on 24/11/20.
//

import UIKit

class SelectedVaccineViewController: UIViewController {
    
    //var doses: [DoseModel] = []
    lazy var selectedView: SelectedVaccineView = {
        let view = SelectedVaccineView()
        view.controller = self
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.delegate = self
        return view
    }()
    
    var doses = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = selectedView
    }
}

extension SelectedVaccineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if doses == 0 {
            tableView.emptyState(textTitle: "Nenhuma dose registrada", textDescription: "Adicione uma nova dose clicando em Nova Dose", image: "Vacina1")
        } else {
            tableView.restore()
        }
        return doses
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return DoseTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

protocol AddDelegate: class {
    func add()
}

extension SelectedVaccineViewController: AddDelegate {
    func add() {
        self.doses += 1
        let destination = NewDoseViewController()
        destination.modalPresentationStyle = .overFullScreen
        navigationController?.present(destination, animated: true)
        //selectedView.tableView.reloadData()
    }
}
