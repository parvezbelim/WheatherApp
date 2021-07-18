//
//  CityWeatherVMProtocol.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 18/7/21.
//

import Foundation

protocol CityWeatherVMProtocol: AnyObject {
    
    var delegate: CityWeatherOutputDelegate? { get set}
    func getCityWeatherDetail()
    
}

