//
//  Person.swift
//  Vaccine
//
//  Created by Anderson Alencar on 25/11/20.
//

import Foundation

class GeneralManagerModel {
    
    var vaccines = [VaccineModel]()
    
    private var vaccinesGeneralModel: [GeneralDataMode]?
    
    static let sharedPerson: GeneralManagerModel = {
        let person = GeneralManagerModel()
        return person
    }()
    
    private init() {
        loadVaccines()
        addVaccines()
    }

    private func addVaccines() {
        if let vaccinesArray = vaccinesGeneralModel {
            for vaccine in vaccinesArray {
                let newVaccine = VaccineModel(idVaccine: Double(vaccine.idVaccine), name: vaccine.nameVaccine, nDoses: vaccine.nDoses, status: .pending, nextDoses: [1, 2])
                vaccines.append(newVaccine)
            }
        }

    }
    
    private func loadVaccines() {
        if let path = Bundle.main.path(forResource: "GeneralData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonResult = try JSONDecoder().decode([GeneralDataMode].self, from: data)
                self.vaccinesGeneralModel = jsonResult
              } catch {
                print(error)
              }
        }
    }
}
