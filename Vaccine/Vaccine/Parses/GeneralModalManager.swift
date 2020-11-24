//
//  GeneralModalManager.swift
//  Vaccine
//
//  Created by Anderson Alencar on 24/11/20.
//

import Foundation

class GeneralManagerModel {
    
    var vaccines: [GeneralDataMode]?
    
    func loadVaccines() {
        if let path = Bundle.main.path(forResource: "GeneralData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonResult = try JSONDecoder().decode([GeneralDataMode].self, from: data)
                vaccines = jsonResult
              } catch {
                print(error)
              }
        }
    }
    
}
