//
//  GeneralDataTableViewCell.swift
//  Vaccine
//
//  Created by David Augusto on 27/11/20.
//

import UIKit

class GeneralDataTableViewCell: UITableViewCell {
    
    static let identifier = "GeneralDataTableViewCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.text = "Dados Gerais"
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
    
    lazy var preventionIcon: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        let configuration = UIImage.SymbolConfiguration(pointSize: 28)
        image.image = UIImage(systemName: "heart.text.square.fill", withConfiguration: configuration)
        image.tintColor = .textGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var preventionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "-"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var recommendedDosesIcon: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .clear
        image.image = UIImage(named: "syringe")
        image.tintColor = .textGray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var recommendedDosesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "Doses recomendadas: "
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
        preventionLabel.text = generalData.prevention
        recommendedDosesLabel.text = "Doses recomendadas: \(generalData.nDoses)"
    }

}

extension GeneralDataTableViewCell: ViewCode {
    func buildHierarchy() {
        addSubview(titleLabel)
        addSubview(viewCard)
        addSubview(preventionIcon)
        addSubview(preventionLabel)
        addSubview(recommendedDosesIcon)
        addSubview(recommendedDosesLabel)
    }

    func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            viewCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            viewCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            viewCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            viewCard.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            preventionIcon.topAnchor.constraint(equalTo: preventionLabel.topAnchor),
            preventionIcon.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 16),
            preventionIcon.heightAnchor.constraint(equalToConstant: 28),
            preventionIcon.widthAnchor.constraint(equalToConstant: 28)
        ])
        NSLayoutConstraint.activate([
            preventionLabel.topAnchor.constraint(equalTo: viewCard.topAnchor, constant: 16),
            preventionLabel.leadingAnchor.constraint(equalTo: preventionIcon.trailingAnchor, constant: 16),
            preventionLabel.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -16),
            preventionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            recommendedDosesIcon.centerYAnchor.constraint(equalTo: recommendedDosesLabel.centerYAnchor),
            recommendedDosesIcon.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 16),
            recommendedDosesIcon.heightAnchor.constraint(equalToConstant: 28),
            recommendedDosesIcon.widthAnchor.constraint(equalToConstant: 28)
        ])
        NSLayoutConstraint.activate([
            recommendedDosesLabel.topAnchor.constraint(equalTo: preventionLabel.bottomAnchor, constant: 16),
            recommendedDosesLabel.leadingAnchor.constraint(equalTo: recommendedDosesIcon.trailingAnchor, constant: 16),
            recommendedDosesLabel.trailingAnchor.constraint(equalTo: viewCard.trailingAnchor, constant: -16),
            recommendedDosesLabel.bottomAnchor.constraint(equalTo: viewCard.bottomAnchor, constant: -16),
            recommendedDosesLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
        
    }

    func aditionalConfigurations() {
        backgroundColor = .clear
    }
    
}
