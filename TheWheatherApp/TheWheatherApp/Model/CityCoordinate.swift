//
//  CityCoordinate.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 16/7/21.
//

import Foundation

struct CityWeatherDetail: Decodable{
    let coord: Coordinates
    let name: String
    let sys: Country
//    let weather: [WeatherData]
//    let wind: WindData
//    let main: MainData
}

struct Country: Decodable {
    let country: String
}

struct MainData: Decodable{
    let humidity: Int
    let temp: Float
}

struct WeatherData: Decodable{
    let description: String
    let id: Int
    let main: String
}

struct WindData: Decodable{
    let deg: Int
    let gust: Float
    let speed: Float
}

struct Coordinates: Decodable{
    let lat: Double
    let lon: Double
}

