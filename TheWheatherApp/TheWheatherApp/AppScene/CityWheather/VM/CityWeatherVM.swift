//
//  CityWeatherVM.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 18/7/21.
//

import Foundation
import Alamofire

class CityWeatherVM: CityWeatherVMProtocol{
    
    var delegate: CityWeatherOutputDelegate?
    var currLoc: UserCurrLocVMModel!
    
    init(_ objCurrUserLoc: UserCurrLocVMModel){
        self.currLoc = objCurrUserLoc
    }
    
    func getCityWeatherDetail(){
        let url = MyWheatherServices.getForcast(city: currLoc.cityName, countryCode: currLoc.country, unit: .Farehnite).path
        AF.request(url).response { responseServer in
            guard let response = responseServer.data, !response.isEmpty else{
                print("ERROR: Failed to get response.")
                return
            }
            do {
                let objJson = try JSONSerialization.jsonObject(with: response, options: [])
                let data = try JSONSerialization.data(withJSONObject: objJson as Any, options: .prettyPrinted)
                print(objJson)
//                let objResponse = try JSONDecoder().decode(CityCoordinates.self, from: data)
            } catch {
                print(error.localizedDescription)
                showAlert(msg: ALERTSOMETHINGWENTWRONG)
            }
        }
    }
}
