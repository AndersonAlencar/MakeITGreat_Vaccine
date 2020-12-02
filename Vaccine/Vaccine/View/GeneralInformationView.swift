//
//  GeneralInformationView.swift
//  Vaccine
//
//  Created by David Augusto on 27/11/20.
//

import UIKit

class GeneralInformationView: UIView {

    lazy var informationTableView: UITableView = {
        let table = UITableView()
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.register(GeneralDataTableViewCell.self, forCellReuseIdentifier: GeneralDataTableViewCell.identifier)
        table.register(AboutVaccineTableViewCell.self, forCellReuseIdentifier: AboutVaccineTableViewCell.identifier)
//        table.rowHeight = UITableView.automaticDimension
//        table.estimatedRowHeight = 300
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension GeneralInformationView: ViewCode {
    func buildHierarchy() {
        addSubview(informationTableView)
    }

    func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            informationTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            informationTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            informationTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            informationTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func aditionalConfigurations() {
        backgroundColor = .white
    }

}
