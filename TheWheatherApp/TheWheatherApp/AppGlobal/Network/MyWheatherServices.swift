//
//  MyWheatherServices.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 16/7/21.
//

import Foundation
import Alamofire


enum MyWheatherServices{
    case getWheatherForLocation(lat: Double,lon: Double)
    case getForcast(city: String,countryCode: String,unit: Units)
}

extension MyWheatherServices{
    var path: String{
        switch self {
        
        case .getWheatherForLocation(let lat,let lon):
            return BASE_URL + "weather?lat=\(lat)&lon=\(lon)&appid=\(KEY_WHEATHERAPI)"
            
        case .getForcast(let city, let countryCode, let unit):
            return BASE_URL + "forecast?q=\(city),\(countryCode)&appid=\(KEY_WHEATHERAPI)&units=\(unit.stringValue)"
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .getWheatherForLocation,.getForcast:
            return .get
        }
    }
}
