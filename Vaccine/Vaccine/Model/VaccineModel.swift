//
//  VaccineModel.swift
//  ModelsVaccine
//
//  Created by Felipe Santana on 23/11/20.
//

import Foundation

class VaccineModel {
    
    enum Status: String{
        case pending = "Vacina Pendente"
        case delayed = "Dose Atrasada"
        case concluded = "Todas as doses tomadas"
        case scheduled = "Próxima dose..."
    }
    
    let idVaccine: Double
    let name: String
    let nDoses: Int
    let nextDosesByMonth: [Int]
    var vaccineStatus: Status
    var dosesTaken: [DoseModel]
    
    init(id: Double, name: String, nDoses: Int, status: Status, nextDoses: [Int]){
        
        self.idVaccine = id
        self.name = name
        self.nDoses = nDoses
        self.vaccineStatus = status
        self.nextDosesByMonth = nextDoses
        self.dosesTaken = []
    }
}
