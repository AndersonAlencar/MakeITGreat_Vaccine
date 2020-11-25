//
//  SelectedVaccineViewController.swift
//  Vaccine
//
//  Created by Helaine Pontes on 24/11/20.
//

import UIKit

class SelectedVaccineViewController: UIViewController {
    
    var vaccineSelected: VaccineModel?
    
    lazy var selectedView: SelectedVaccineView = {
        let view = SelectedVaccineView()
        view.controller = self
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.title = vaccineSelected?.name
    }
    
    override func loadView() {
        self.view = selectedView
    }
}

extension SelectedVaccineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vaccineSelected?.dosesTaken.isEmpty == true {
            tableView.emptyState(textTitle: "Nenhuma dose registrada", textDescription: "Adicione uma nova dose clicando em Nova Dose", image: "Vacina1")
        } else {
            tableView.restore()
        }
        return vaccineSelected?.dosesTaken.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DoseTableViewCell.identifier) as! DoseTableViewCell
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        let doseDate = formatter.string(from: vaccineSelected?.dosesTaken[indexPath.row].date ?? Date())
        let doseNumber = String(indexPath.row + 1) + "ª Dose"
        
        cell.setup(doseNumber: doseNumber, date: doseDate)
        
        return cell
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
        let destination = NewDoseViewController()
        destination.modalPresentationStyle = .overFullScreen
        destination.vaccineSelected = self.vaccineSelected
        destination.delegate = self
        navigationController?.present(destination, animated: true)
    }
}

protocol ReloadData: class {
    func reloadData()
}

extension SelectedVaccineViewController: ReloadData {
    func reloadData() {
        self.selectedView.tableView.reloadData()
    }
}
