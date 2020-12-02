//
//  AboutVaccineTableViewCell.swift
//  Vaccine
//
//  Created by David Augusto on 30/11/20.
//

import UIKit

class AboutVaccineTableViewCell: UITableViewCell {
    
    static let identifier = "AboutVaccineTableViewCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.text = "Sobre a Vacina"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var indicationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.text = "Indicações"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var indicationTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "-"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var adverseEffectsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.text = "Efeitos Adversos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var adverseEffectsTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "-"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var againstIndicationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.text = "Contraindicação"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var againstIndicationTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textGray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "-"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var viewCard: UIView = {
        let view = UIView()
        view.backgroundColor = .cardGray
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var alertIcon: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        let configuration = UIImage.SymbolConfiguration(pointSize: 50)
        image.image = UIImage(systemName: "exclamationmark.circle.fill", withConfiguration: configuration)
        image.tintColor = .darkGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "Informações sobre a vacina foram retiradas do site SIBM - Família. Antes de tomar qualquer vacina consulte um médico para mais informações."
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with generalData: GeneralDataMode) {
        indicationTextLabel.text = generalData.indication
        adverseEffectsTextLabel.text = generalData.adverseEffects
        againstIndicationTextLabel.text = generalData.againstIndication
        
    }

}

extension AboutVaccineTableViewCell: ViewCode {
    func buildHierarchy() {
        addSubview(titleLabel)
        addSubview(indicationLabel)
        addSubview(indicationTextLabel)
        addSubview(adverseEffectsLabel)
        addSubview(adverseEffectsTextLabel)
        addSubview(againstIndicationLabel)
        addSubview(againstIndicationTextLabel)
        addSubview(viewCard)
        addSubview(alertIcon)
        addSubview(alertLabel)
        
    }

    func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        NSLayoutConstraint.activate([
            indicationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            indicationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            indicationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            indicationTextLabel.topAnchor.constraint(equalTo: indicationLabel.bottomAnchor, constant: 4),
            indicationTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            indicationTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            indicationTextLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            adverseEffectsLabel.topAnchor.constraint(equalTo: indicationTextLabel.bottomAnchor, constant: 15),
            adverseEffectsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            adverseEffectsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            adverseEffectsTextLabel.topAnchor.constraint(equalTo: adverseEffectsLabel.bottomAnchor, constant: 4),
            adverseEffectsTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            adverseEffectsTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            adverseEffectsTextLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            againstIndicationLabel.topAnchor.constraint(equalTo: adverseEffectsTextLabel.bottomAnchor, constant: 15),
            againstIndicationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            againstIndicationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            againstIndicationTextLabel.topAnchor.constraint(equalTo: againstIndicationLabel.bottomAnchor, constant: 4),
            againstIndicationTextLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            againstIndicationTextLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            againstIndicationTextLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            viewCard.topAnchor.constraint(equalTo: againstIndicationTextLabel.bottomAnchor, constant: 20),
            viewCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            viewCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            viewCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50)
        ])
        NSLayoutConstraint.activate([
            alertIcon.centerYAnchor.constraint(equalTo: viewCard.centerYAnchor),
            alertIcon.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 16),
            alertIcon.heightAnchor.constraint(equalToConstant: 50),
            alertIcon.widthAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            alertLabel.topAnchor.constraint(equalTo: viewCard.topAnchor, constant: 16),
            alertLabel.leadingAnchor.constraint(equalTo: alertIcon.trailingAnchor, constant: 16),
            alertLabel.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -16),
            alertLabel.bottomAnchor.constraint(equalTo: viewCard.bottomAnchor, constant: -16),
            alertLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
    }

    func aditionalConfigurations() {
        backgroundColor = .clear
    }
    
}
