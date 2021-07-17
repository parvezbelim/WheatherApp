//
//  CityCoordinate.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 16/7/21.
//

import Foundation

struct CityCoordinates: Decodable{
    let coord: Coordinates
    let name: String
    let sys: Country
}

struct Coordinates: Decodable{
    let lat: Double
    let lon: Double
}

struct Country: Decodable {
    let country: String
}

