//
//  GeneralInformationViewController.swift
//  Vaccine
//
//  Created by David Augusto on 27/11/20.
//

import UIKit

class GeneralInformationViewController: UIViewController {

    var vaccineSelected: Vaccine?
    var manager = GeneralManagerModel.sharedPerson
    
    lazy var generalInformationView: GeneralInformationView = {
        let myView = GeneralInformationView()
        myView.informationTableView.delegate = self
        myView.informationTableView.dataSource = self
        return myView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = vaccineSelected?.name
        self.navigationController?.navigationBar.tintColor = .purpleAction
        let closeButton = UIBarButtonItem(title: "Fechar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(closeButtonAction))
        self.navigationItem.leftBarButtonItem = closeButton
        
        self.view = generalInformationView
    }
    
    @objc func closeButtonAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

}

extension GeneralInformationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GeneralDataTableViewCell.identifier, for: indexPath) as! GeneralDataTableViewCell
            cell.configure(with: manager.getVaccine(byId: vaccineSelected!.idVaccine)!)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AboutVaccineTableViewCell.identifier, for: indexPath) as! AboutVaccineTableViewCell
            cell.configure(with: manager.getVaccine(byId: vaccineSelected!.idVaccine)!)
            cell.selectionStyle = .none
            return cell
        }
    }

}
