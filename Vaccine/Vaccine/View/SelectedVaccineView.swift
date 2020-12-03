//
//  SelectedVaccineView.swift
//  Vaccine
//
//  Created by Helaine Pontes on 24/11/20.
//

import UIKit

class SelectedVaccineView: UIView {
    
    var controller: SelectedVaccineViewController? = SelectedVaccineViewController()
    
    weak var delegate: AddDelegate?
    
    lazy var modalBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .modalBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .white
        table.register(DoseTableViewCell.self, forCellReuseIdentifier: DoseTableViewCell.identifier)
        table.register(WarningDoseTableViewCell.self, forCellReuseIdentifier: WarningDoseTableViewCell.identifier)
        
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
        modalBackgroundViewConstraint()
        modalBackgroundView.isHidden = true
        self.backgroundColor = .white
        
        doseButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        
    }
    
    @objc func test() {
        delegate?.add()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func modalBackgroundViewConstraint() {
        self.addSubview(modalBackgroundView)
        
        NSLayoutConstraint.activate([
            modalBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            modalBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            modalBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            modalBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
    
    func tableConstraint() {
        self.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
    
    func labelConstraint() {
        self.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)])
    }
    
    func buttonConstraint() {
        self.addSubview(doseButton)
        
        NSLayoutConstraint.activate([
            doseButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            doseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)])
    }
    
}
