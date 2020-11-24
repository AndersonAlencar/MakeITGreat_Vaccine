//
//  SelectedVaccineViewController.swift
//  Vaccine
//
//  Created by Helaine Pontes on 24/11/20.
//

import UIKit

class SelectedVaccineViewController: UIViewController {
    
    var doses: [DoseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        let view = SelectedVaccineView()
        view.controller = self
        view.tableView.delegate = self
        view.tableView.dataSource = self
        self.view = view
    }
}
extension SelectedVaccineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return DoseTableViewCell()
    }
    
}
