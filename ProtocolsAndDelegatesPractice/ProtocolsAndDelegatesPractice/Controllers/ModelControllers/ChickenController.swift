//
//  ChickenController.swift
//  ProtocolsAndDelegatesPractice
//
//  Created by Ben Erekson on 7/22/21.
//

import Foundation

class ChickenController{
    var Chickens: [Chicken] = []
    static var sharedInstance = ChickenController()
    
    
    //MARK: - CRUD Functions
    func createChicken(name: String, birthDate: Date, weight: Double, personalityTraits: String){
        Chickens.append(Chicken(name: name, birthDate: birthDate, weight: weight, personalityTraits: personalityTraits))
        saveToPresistenceStore()
    }
    func updateChicken(chicken: Chicken, newName: String, newBirthDate: Date, newWeight: Double, newPersonalityTraits: String){
        guard let index = Chickens.firstIndex(of: chicken) else {return}
        
        Chickens[index].name = newName
        Chickens[index].birthDate = newBirthDate
        Chickens[index].weight = newWeight
        Chickens[index].personalityTraits = newPersonalityTraits
        
        saveToPresistenceStore()
    }
    func deleteChicken(chicken: Chicken){
        guard let index = Chickens.firstIndex(of: chicken) else {return}
        
        Chickens.remove(at: index)
        
        saveToPresistenceStore()
    }
    
    //MARK: - Persistance
    func createPresistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("chickens.json")
        return fileURL
    }
    
    func saveToPresistenceStore() {
        do {
            let data = try JSONEncoder().encode(Chickens)
            try data.write(to: createPresistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPresistenceStore() {
        do {
            let data = try Data(contentsOf: createPresistenceStore())
            Chickens = try JSONDecoder().decode([Chicken].self, from: data)
            
        }catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
}
