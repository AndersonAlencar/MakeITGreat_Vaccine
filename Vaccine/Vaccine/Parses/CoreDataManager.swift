//
//  CoreDataManager.swift
//  Vaccine
//
//  Created by Anderson Alencar on 02/12/20.
//

import Foundation
import CoreData

class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Vaccine")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func generateVaccine() {
        let context = self.persistentContainer.viewContext
        //user
        let user = User(context: context)
        
       //vaccine
        let vaccine = Vaccine(context: context)
        vaccine.idVaccine = 1
        vaccine.name = "BCG"
        vaccine.nDoses = 2
        vaccine.vaccineStatus = 0
        vaccine.nextDosesByMonth = [2, 2]
        
        //dose
        let dose = Dose(context: context)
        dose.idDose = 1
        dose.date = Date()
        
        //add dose
        vaccine.addToDose(dose)
        
        //add vaccine
        user.addToVaccines(vaccine)
        saveContext()
    }
    
    func getVaccine() {
        let context = self.persistentContainer.viewContext
        do {
            let user = try context.fetch(User.fetchRequest()) as [User]
            let vaccine = user.first?.vaccines as! Set<Vaccine>
            print(vaccine.first?.name ?? "nome da vacina não encontrada")
        } catch {
            print("Deu merda: \(error)")
        }
    }
    
    func getUser() -> User {
        let context = self.persistentContainer.viewContext
        var setUser = [User]()
        do {
            setUser = try (context.fetch(User.fetchRequest()) as? [User])!
        } catch {
            print("Deu erro no user: \(error)")
        }
        
        if setUser.isEmpty {
            let person = Person.sharedPerson
            let user = User(context: context)
            for vaccineModel in person.vaccines {
                let vaccine = Vaccine(context: context)
                vaccine.idVaccine = vaccineModel.idVaccine
                vaccine.name = vaccineModel.name
                vaccine.nDoses = Int64(vaccineModel.nDoses)
                vaccine.vaccineStatus = 0
                vaccine.nextDosesByMonth = vaccineModel.nextDosesByMonth
                user.addToVaccines(vaccine)
            }
            saveContext()
            return user
        } else {
            return setUser.first!
        }
    }
}
