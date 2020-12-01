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
        self.navigationController?.navigationBar.tintColor = .purpleAction
    }
    
    override func loadView() {
        self.view = selectedView
    }
}

extension SelectedVaccineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                if vaccineSelected?.dosesTaken.isEmpty == true {
                    tableView.emptyState(textTitle: "Nenhuma dose registrada", textDescription: "Adicione uma nova dose clicando em Nova Dose", image: "Vacina1")
                } else {
                    tableView.restore()
                }
                return vaccineSelected?.dosesTaken.count ?? 0
            default:
                if vaccineSelected?.dosesTaken.isEmpty == true {
                    return 0
                } else {
                    return 1
                }
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: DoseTableViewCell.identifier) as! DoseTableViewCell
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/yy"
                let doseDate = formatter.string(from: vaccineSelected?.dosesTaken[indexPath.row].date ?? Date())
                let doseNumber = String(indexPath.row + 1) + "ª Dose"
                cell.selectionStyle = .none
                cell.setup(doseNumber: doseNumber, date: doseDate)
                
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: WarningDoseTableViewCell.identifier) as! WarningDoseTableViewCell
                cell.selectionStyle = .none
                return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//        }
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Deletar") { (action, view, completion) in
            self.vaccineSelected?.dosesTaken.remove(at: indexPath.row)
            self.selectedView.tableView.reloadData()
            completion(true)
        }
        
        action.image = UIImage(named: "trashIcon")
        action.backgroundColor = .white
        
        return action
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
        destination.newDoseView.doseNumber.text = String((self.vaccineSelected?.dosesTaken.count ?? 0) + 1) + "ª Dose"
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
