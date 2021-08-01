//
//  CityWeatherVMProtocol.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 18/7/21.
//

import Foundation

protocol CityWeatherVMProtocol: AnyObject {
    
    var delegate: CityWeatherOutputDelegate? { get set}
    var arrWeatherData: [CityForcastVMModel] { get set}

    func getCityWeatherDetail()
}

