//
//  WarningDoseTableViewCell.swift
//  Vaccine
//
//  Created by Helaine Pontes on 26/11/20.
//

import UIKit

class WarningDoseTableViewCell: UITableViewCell {
    
    static let identifier = "WarningDoseTableViewCell"
    
    let warningText: UILabel = {
        let label = UILabel()
        label.text = "Sempre leve o seu cartão de vacinação para registrar as doses. Esse aplicativo não substitui orientação médica."
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .textGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        warningTextConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func warningTextConstraint() {
        addSubview(warningText)
        
        NSLayoutConstraint.activate([
            warningText.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            warningText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            warningText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            warningText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
    
}
