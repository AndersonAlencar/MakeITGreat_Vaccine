//
//  SelectedVaccineView.swift
//  Vaccine
//
//  Created by Helaine Pontes on 24/11/20.
//

import UIKit

class SelectedVaccineView: UIView {
    
    var controller: SelectedVaccineViewController? = SelectedVaccineViewController()
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        
        return table
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Doses Ministradas"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    lazy var doseButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Nova Dose", for: .normal)
        button.setTitleColor(.purpleAction, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        labelConstraint()
        tableConstraint()
        buttonConstraint()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableConstraint() {
        self.addSubview(tableView)
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16), tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16), tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16), tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
    
    func labelConstraint() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16), titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)])
    }
    func buttonConstraint() {
        self.addSubview(doseButton)
        NSLayoutConstraint.activate([doseButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor), doseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)])
    }
    
}
