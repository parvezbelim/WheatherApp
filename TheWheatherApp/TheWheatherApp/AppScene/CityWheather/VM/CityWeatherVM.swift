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
    
    func getTitle() -> String{
        return "\(currLoc.cityName) Today"
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
                let data = try JSONSerialization.data(withJSONObject: objJson as Any, options: .prettyPrinted)
                let objResponse = try JSONDecoder().decode(CityForcastList.self, from: data)
               
                self.arrWeatherData = objResponse.list.compactMap({ objCityWeather in
                    return CityForcastVMModel(temp: objCityWeather.main.temp,
                                              desc: objCityWeather.weather.first?.description ?? "",
                                              wind: objCityWeather.wind,
                                              humidity: objCityWeather.main.humidity,
                                              type: CityWeatherType.getWeatherType(strWeatherType: objCityWeather.weather.first?.main.lowercased() ?? ""),
                                              time: self.getTime(timeStamp: objCityWeather.dt))
                })
                self.delegate?.cityWheatherLoaded()
                
            } catch let error{
                print(error)
                showAlert(msg: ALERTSOMETHINGWENTWRONG)
            }
        }
    }
    
    private func getTime(timeStamp: Double) -> String{
        let timestamp =  NSDate(timeIntervalSince1970: timeStamp)

        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: timestamp as Date)
    }
}

struct CityForcastVMModel{
    let temp: Float
    let desc: String
    let wind: WindData
    let humidity: Int
    let type: CityWeatherType
    let time: String
}
