//
//  UserLocationVM.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 16/7/21.
//

import Foundation
import Alamofire

class UserLocationVM : UserLocVMProtocol{
    var delegate: UserLocOutputDelegate?
    private var objCityUseCase: CityRecordsUseCase!
    private var objCurrLoc: UserCurrLocVMModel?

    init(_ cityUseCase: CityRecordsUseCase){
        self.objCityUseCase = cityUseCase
    }
    
    func getWheatherForUserLoc(lat:Double,long:Double){
        let url = MyWheatherServices.getWheatherForLocation(lat: lat, lon: long).path
        AF.request(url).response { responseServer in
            guard let response = responseServer.data, !response.isEmpty else{
                print("ERROR: Failed to get response.")
                return
            }
            do {
                let objJson = try JSONSerialization.jsonObject(with: response, options: [])
                let data = try JSONSerialization.data(withJSONObject: objJson as Any, options: .prettyPrinted)
                let objResponse = try JSONDecoder().decode(CityWeatherDetail.self, from: data)
                self.objCurrLoc = UserCurrLocVMModel(cityName: objResponse.name,
                                                lat: objResponse.coord.lat,
                                                lon: objResponse.coord.lon,
                                                country: objResponse.sys.country)
                if let objLoc = self.objCurrLoc{
                    self.delegate?.responseReceived(locDetail: objLoc)
                }
            } catch {
                print(error.localizedDescription)
                showAlert(msg: ALERTSOMETHINGWENTWRONG)
            }
        }
    }
    
    func saveUserCurrLocation(){
        guard let userLoc = objCurrLoc else { return }
        objCityUseCase.insertCurrLoc(loc: userLoc)
    }
}

struct UserCurrLocVMModel{
    let cityName:String
    let lat: Double
    let lon: Double
    let country: String
}


