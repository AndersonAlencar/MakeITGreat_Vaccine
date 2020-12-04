//
//  Enums.swift
//  Vaccine
//
//  Created by Anderson Alencar on 04/12/20.
//

import Foundation

enum StatusVaccine: Int64 {
    case pending
    case delayed
    case concluded
    case scheduled
    
    var description: String {
        switch self {
            case .pending: return "Vacina Pendente"
            case .delayed: return "Dose Atrasada"
            case .concluded: return "Todas as doses tomadas"
            case .scheduled: return "Próxima dose..."
        }
    }
}
