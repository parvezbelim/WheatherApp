//
//  TaxiServices.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 11/6/21.
//

import Foundation
import Alamofire

enum TaxiServices{
    case getTaxiNearBy
}

extension TaxiServices{
    var path: String{
        switch self {
        case .getTaxiNearBy: return "PoiService/poi/v1"
        }
    }
    
    var method: HTTPMethod{
        switch self {
        case .getTaxiNearBy: return .get
        }
    }
}
