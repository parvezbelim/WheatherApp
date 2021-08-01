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
    var arrWeatherData = [CityForcastVMModel]()
    
    init(_ objCurrUserLoc: UserCurrLocVMModel){
        self.currLoc = objCurrUserLoc
    }
    
    func getCityWeatherDetail(){
        let url = MyWheatherServices.getForcast(city: currLoc.cityName, countryCode: currLoc.country, unit: .Celcius).path
        AF.request(url).response { responseServer in
            guard let response = responseServer.data, !response.isEmpty else{
                print("ERROR: Failed to get response.")
                return
            }
            do {
                let objJson = try JSONSerialization.jsonObject(with: response, options: [])
                print(objJson)
                let data = try JSONSerialization.data(withJSONObject: objJson as Any, options: .prettyPrinted)
                let objResponse = try JSONDecoder().decode(CityForcastList.self, from: data)
                self.arrWeatherData = objResponse.list.compactMap({ objCityWeather in
                    return CityForcastVMModel(temp: objCityWeather.main.temp,
                                              desc: objCityWeather.weather.first?.description ?? "",
                                              wind: objCityWeather.wind,
                                              humidity: objCityWeather.main.humidity,
                                              type: CityWeatherType(rawValue: objCityWeather.weather.first?.main ?? "") ?? .Other)
                })
                self.delegate?.cityWheatherLoaded()
                
            } catch let error{
                print(error)
                showAlert(msg: ALERTSOMETHINGWENTWRONG)
            }
        }
    }
}

struct CityForcastVMModel{
    let temp: Float
    let desc: String
    let wind: WindData
    let humidity: Int
    let type: CityWeatherType
}
