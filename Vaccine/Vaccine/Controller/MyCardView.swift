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
        //vaccinesTable.separatorStyle = .none
        vaccinesTable.showsVerticalScrollIndicator = false
        vaccinesTable.bounces = false
        vaccinesTable.register(VaccineCellTableViewCell.self, forCellReuseIdentifier: VaccineCellTableViewCell.identifier)
        vaccinesTable.delegate = self
        vaccinesTable.dataSource = self
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
            vaccinesTable.leadingAnchor.constraint(equalTo: leadingAnchor),
            vaccinesTable.trailingAnchor.constraint(equalTo: trailingAnchor),
            vaccinesTable.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    func aditionalConfigurations() {
        backgroundColor = .white
    }
}

extension MyCardView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VaccineCellTableViewCell.identifier, for: indexPath) as! VaccineCellTableViewCell
        cell.configure(with: VaccineModel.init(id: 1, name: "Febre Amarela", nDoses: 3, status: .pending, nextDoses: [2, 2]))
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}
