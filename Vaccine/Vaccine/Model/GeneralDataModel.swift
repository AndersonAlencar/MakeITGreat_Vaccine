//
//  GeneralDataModel.swift
//  Vaccine
//
//  Created by Helaine Pontes on 24/11/20.
//

import Foundation

class GeneralDataModel {
    var idVaccine: Int
    var nameVaccine: String
    var prevention: String
    var nDoses: String
    var indication: String
    var adverseEffects: String
    var againstIndication: String

    init(idVaccine: Int, nameVaccine: String, prevention: String, nDoses: String, indication: String, adverseEffects: String, againstIndication: String) {
        self.idVaccine = idVaccine
        self.nameVaccine = nameVaccine
        self.prevention = prevention
        self.nDoses = nDoses
        self.indication = indication
        self.adverseEffects = adverseEffects
        self.againstIndication = againstIndication
    }
}
