//
//  MyCardView.swift
//  Vaccine
//
//  Created by Anderson Alencar on 24/11/20.
//

import UIKit

class MyCardView: UIView {

    lazy var segmentedVaccine: UISegmentedControl = {
        let segmentedVaccine = UISegmentedControl()
        segmentedVaccine.insertSegment(withTitle: "Todas", at: 0, animated: true)
        segmentedVaccine.insertSegment(withTitle: "Tomadas", at: 1, animated: true)
        segmentedVaccine.insertSegment(withTitle: "Pendentes", at: 2, animated: true)
        segmentedVaccine.selectedSegmentIndex = 0
        segmentedVaccine.translatesAutoresizingMaskIntoConstraints = false
        segmentedVaccine.backgroundColor = .cardGray
        return segmentedVaccine
    }()

    lazy var vaccinesTable: UITableView = {
        let vaccinesTable = UITableView()
        vaccinesTable.separatorStyle = .none
        vaccinesTable.showsVerticalScrollIndicator = false
        vaccinesTable.bounces = false
        vaccinesTable.register(VaccineCellTableViewCell.self, forCellReuseIdentifier: VaccineCellTableViewCell.identifier)
        vaccinesTable.tableFooterView = UIView()
        vaccinesTable.translatesAutoresizingMaskIntoConstraints = false
        return vaccinesTable
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MyCardView: ViewCode {
    func buildHierarchy() {
        addSubview(segmentedVaccine)
        addSubview(vaccinesTable)
    }

    func setUpLayoutConstraints() {
        NSLayoutConstraint.activate([
            segmentedVaccine.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            segmentedVaccine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            segmentedVaccine.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            vaccinesTable.topAnchor.constraint(equalTo: segmentedVaccine.bottomAnchor, constant: 10),
            vaccinesTable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            vaccinesTable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            vaccinesTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    func aditionalConfigurations() {
        backgroundColor = .white
    }
}
