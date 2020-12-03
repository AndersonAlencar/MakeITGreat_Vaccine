//
//  DoseModel.swift
//  ModelsVaccine
//
//  Created by Felipe Santana on 23/11/20.
//

import Foundation

class DoseModel: NSObject, Codable {
    let idDose: Double
    var date: Date
    
    init(idDoses: Double, date: Date) {
        self.idDose = idDoses
        self.date = date
    }
}
