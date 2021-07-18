//
//  WeatherVCRouter.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 18/7/21.
//

import Foundation
import UIKit

final class CityWeatherVCRouter{
    static func make(_ userLoc: UserCurrLocVMModel) -> CityWeatherDetailVC{
        let vc: CityWeatherDetailVC = UIStoryboard.load(.main, with: "CityWeatherDetailVC")
        vc.vm = CityWeatherVM(userLoc)
        return vc
    }
}

