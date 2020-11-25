//
//  DoseTableViewCell.swift
//  Vaccine
//
//  Created by Felipe Santana on 24/11/20.
//

import UIKit

class DoseTableViewCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    static let identifier = "DoseTableViewCell"
    
    let backView: UIView = {
        let backView = UIView()
        backView.backgroundColor = .cardGray
        backView.layer.cornerRadius = 8
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        return backView
    }()
    
    let doseTitle: UILabel = {
        let label = UILabel()
        label.text = "Dose 1"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dateTitle: UILabel = {
        let label = UILabel()
        label.text = "12/12/20"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .purpleAction
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let calendarSymbol: UIImageView = {
        let calendar = UIImageView()
        calendar.image = UIImage(systemName: "calendar")
        calendar.tintColor = .purpleAction
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        return calendar
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backViewContraint()
        doseTitleConstraint()
        dateTitleConstraint()
        calendarSymbolConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func backViewContraint() {
        self.addSubview(backView)
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: self.topAnchor),
            backView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
    }
    
    func doseTitleConstraint() {
        self.addSubview(doseTitle)
        
        NSLayoutConstraint.activate([
            doseTitle.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            doseTitle.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: 20)
        ])
    }
    
    func dateTitleConstraint() {
        self.addSubview(dateTitle)
        
        NSLayoutConstraint.activate([
            dateTitle.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            dateTitle.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: -20)
        ])
        
    }
    
    func calendarSymbolConstraint() {
        self.addSubview(calendarSymbol)
        
        NSLayoutConstraint.activate([
            calendarSymbol.centerYAnchor.constraint(equalTo: backView.centerYAnchor),
            calendarSymbol.trailingAnchor.constraint(equalTo: dateTitle.leadingAnchor, constant: -8)
        ])
    }
}
