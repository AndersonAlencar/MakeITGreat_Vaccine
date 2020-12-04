//
//  CoreDataManager.swift
//  Vaccine
//
//  Created by Anderson Alencar on 02/12/20.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static var persistentContainer: NSPersistentContainer = {
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
        let context = CoreDataManager.persistentContainer.viewContext
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
    
    func getUser() -> User {
        let context = CoreDataManager.persistentContainer.viewContext
        var setUser = [User]()
        do {
            setUser = try (context.fetch(User.fetchRequest()) as? [User])!
        } catch {
            print("Deu erro no user: \(error)")
        }
        
        if setUser.isEmpty {
            let person = GeneralManagerModel.sharedPerson
            let user = User(context: context)
            for vaccineModel in person.vaccines {
                let vaccine = Vaccine(context: context)
                vaccine.idVaccine = vaccineModel.idVaccine
                vaccine.name = vaccineModel.name
                vaccine.nDoses = Int64(vaccineModel.nDoses)
                vaccine.vaccineStatus = 0
                vaccine.nextDosesByMonth = 1 //vaccineModel.nextDosesByMonth
                user.addToVaccines(vaccine)
            }
            saveContext()
            return user
        } else {
            return setUser.first!
        }
    }
    
    func fetchVaccines() -> [Vaccine] {
        let context = CoreDataManager.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Vaccine")
        request.returnsObjectsAsFaults = false
        var orderedVaccines = [Vaccine]()
        do {
            let result = try context.fetch(request)
            let arrayVaccines = result as! [Vaccine]
            orderedVaccines = arrayVaccines.sorted(by: { (vaccine1, vaccine2) -> Bool in
                vaccine1.idVaccine < vaccine2.idVaccine
            })
          } catch {
            print("Failed")
        }
        return orderedVaccines
    }
    
    func louvor() {
//        let newDose = Dose(context: persistentContainer.viewContext)
//        newDose.date = Date()
//        newDose.idDose = 1
        let vaccines = fetchVaccines()
        let doses = (vaccines.first?.dose)! as! Set<Dose>
        print(doses)
//        vaccines.first?.addToDose(newDose)
//        saveContext()
    }
}
