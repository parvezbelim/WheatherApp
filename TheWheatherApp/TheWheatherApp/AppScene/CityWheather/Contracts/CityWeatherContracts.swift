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
    case Rain,Clouds,Sun, Clear, Other
}
