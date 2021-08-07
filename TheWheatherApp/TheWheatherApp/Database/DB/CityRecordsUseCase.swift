//
//  CityRecordsUseCase.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 16/7/21.
//

import Foundation

protocol CityRecordsUseCase: Any {
    func getCityList(_ completion:([UserCurrLocVMModel]?)->())
    func insertCurrLoc(loc:UserCurrLocVMModel)
    func removeCity(cityName: String)
}
