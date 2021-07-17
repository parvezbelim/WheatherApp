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
}

extension MyWheatherServices{
    var path: String{
        switch self {
        case .getWheatherForLocation(let lat,let lon):
            return BASE_URL + "lat=\(lat)&lon=\(lon)&appid=\(KEY_WHEATHERAPI)"
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .getWheatherForLocation: return .get
        }
    }
}
