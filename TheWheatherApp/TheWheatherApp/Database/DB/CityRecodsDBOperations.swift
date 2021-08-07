//
//  CityRecordsUseCase.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 16/7/21.
//

import Foundation
import CoreData

class CityRecodsDBOperations: CityRecordsUseCase{
    private lazy var objManagedContext = AppdelegateObj?.persistentContainer.viewContext

    func getCityList(_ completion:([UserCurrLocVMModel]?)->()) {
        guard let context = objManagedContext else { return }
        let fetchReq = NSFetchRequest<Cities>(entityName: "Cities")
        do {
            let arrCity = try context.fetch(fetchReq)
            let arrLocations = arrCity.map( { UserCurrLocVMModel(cityName: $0.name ?? "", lat: $0.lat, lon: $0.lon, country: $0.country ?? "")})
            completion(arrLocations)
        }
        catch let error{
            print(error)
        }
        completion(nil)
    }
    
    func removeCity(cityName: String){
        guard let context = objManagedContext else { return }

        let fetchReq = NSFetchRequest<Cities>(entityName: "Cities")
        fetchReq.predicate = NSPredicate(format: "name == %@", "\(cityName)")
        do {
            let cities = try context.fetch(fetchReq)
            for city in cities{
               context.delete(city)
            }
           try context.save()
        } catch let error {
            print(error)
        }
    }
    
    func insertCurrLoc(loc: UserCurrLocVMModel) {
        guard let context = objManagedContext else { return }
        
        let objCity = Cities(context: context)
        objCity.country = loc.country
        objCity.lat = loc.lat
        objCity.lon = loc.lon
        objCity.name = loc.cityName
        do {
            try context.save()
        } catch let error {
            print(error)
        }
    }
}



