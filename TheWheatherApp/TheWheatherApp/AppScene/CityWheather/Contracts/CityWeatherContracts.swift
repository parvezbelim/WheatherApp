//
//  CityWeatherContracts.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 18/7/21.
//

import Foundation

protocol CityWeatherOutputDelegate: Any {
    func cityWheatherLoaded()
}

enum Units{
    case Farehnite, Celcius
    
    var stringValue: String{
        switch self {
        case .Celcius:
            return "metric"
        case .Farehnite:
            return "imperial"
        }
    }
}

enum CityWeatherType: String{
    case Rain,Clouds,Sun, Clear,Snow,Wind, Other
    
    
    var iconName: String{
        switch self {
        case .Rain:
            return "cloud.rain"
        case .Clouds:
            return "cloud"
        case .Sun:
            return "sun.max"
        case .Snow:
            return "snow"
        case .Wind:
            return "wind"
        default:
            return "sun.min"
        }
    }
    
    static func getWeatherType(strWeatherType: String) -> CityWeatherType{
        if strWeatherType.contains("rain"){
            return .Rain
        }
        else if strWeatherType.contains("cloud"){
            return .Clouds
        }
        else if strWeatherType.contains("sun"){
            return .Sun
        }
        else if strWeatherType.contains("snow"){
            return .Snow
        }
        else if strWeatherType.contains("wind"){
            return .Wind
        }
        else{
            return .Clear
        }
    }
}
