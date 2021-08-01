//
//  CityForcastList.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 19/7/21.
//

import Foundation

struct CityForcastList: Decodable {
    let cnt: Int
    let cod: String
    let list: [Forcast]
}

struct Forcast: Decodable{
    let weather: [WeatherData]
    let wind: WindData
    let main: MainData
    let dt: Double
    
}


