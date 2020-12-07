//
//  SelectedVaccineViewController.swift
//  Vaccine
//
//  Created by Helaine Pontes on 24/11/20.
//

import UIKit

class SelectedVaccineViewController: UIViewController {
    
    var vaccineSelected: Vaccine?
    var coreDataManager = CoreDataManager()
    
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
        let informationButton = UIBarButtonItem(image: UIImage(systemName: "exclamationmark.circle"), style: UIBarButtonItem.Style.done, target: self, action: #selector(informationAction))
        self.navigationItem.rightBarButtonItem = informationButton
    }
    
    override func loadView() {
        self.view = selectedView
    }
    
    @objc func informationAction() {
        let destination = GeneralInformationViewController()
        destination.vaccineSelected = self.vaccineSelected
        let informationView = UINavigationController(rootViewController: destination)
        informationView.navigationBar.standardAppearance.configureWithTransparentBackground()
        navigationController?.present(informationView, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
    }
    
    func changeColorBar() {
        let colorView = UIView()
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        colorView.isUserInteractionEnabled = false
        navigationController?.navigationBar.addSubview(colorView)
        navigationController?.navigationBar.sendSubviewToBack(colorView)
        colorView.frame = CGRect(x: 0, y: -(window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0), width: (navigationController?.navigationBar.frame.width)!, height: window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
        colorView.backgroundColor = .white
    }
}

extension SelectedVaccineViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0:
                if vaccineSelected?.dose!.count == 0 {
                    tableView.emptyState(textTitle: "Nenhuma dose registrada", textDescription: "Adicione uma nova dose clicando em Nova Dose", image: "Vacina1")
                } else {
                    tableView.restore()
                }
                return vaccineSelected?.dose!.count ?? 0
            default:
                if vaccineSelected?.dose!.count == 0 {
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
                let doseDate = formatter.string(from: vaccineSelected?.orderedDose()[indexPath.row].date ?? Date())
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
        self.edit(dose: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Deletar") { [self] (action, view, completion) in
            self.vaccineSelected?.removeFromDose((vaccineSelected?.orderedDose()[indexPath.row])!)
            if (vaccineSelected?.dose!.count)! < vaccineSelected!.nDoses {
                vaccineSelected?.vaccineStatus = 0
            }
            coreDataManager.saveContext()
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
    func edit(dose: Int)
}

extension SelectedVaccineViewController: AddDelegate {
    func add() {
        let destination = NewDoseViewController()
        destination.modalPresentationStyle = .overFullScreen
        destination.vaccineSelected = self.vaccineSelected
        destination.delegate = self
        destination.newDoseView.doseNumber.text = "Nova Dose"
        destination.delegateViewHidden = self
        selectedView.modalBackgroundView.isHidden = false
        navigationController?.present(destination, animated: true)
    }
    
    func edit(dose: Int) {
        let destination = EditViewController()
        destination.modalPresentationStyle = .overFullScreen
        destination.vaccineSelected = self.vaccineSelected
        destination.selectedDose = dose
        destination.delegate = self
        destination.editDoseView.doseNumber.text = "Editar Dose"
        destination.delegateViewHidden = self
        selectedView.modalBackgroundView.isHidden = false
        navigationController?.present(destination, animated: true)
    }
}

protocol ReloadData: class {
    func reloadData()
}

protocol ViewHidden: class {
    func viewHidden()
}
extension SelectedVaccineViewController: ReloadData, ViewHidden {
    func reloadData() {
        self.selectedView.tableView.reloadData()
    }
    
    func viewHidden() {
        selectedView.modalBackgroundView.isHidden = true
    }
}
