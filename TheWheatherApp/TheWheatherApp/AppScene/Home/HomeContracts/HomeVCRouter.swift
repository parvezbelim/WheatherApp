//
//  HomeVCRouter.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 17/7/21.
//

import Foundation
import UIKit

final class HomeVCRouter{
    static func make() -> HomeVC{
        let vc: HomeVC = UIStoryboard.load(.main, with: "HomeVC")
        vc.vm = HomeVM(CityRecodsDBOperations())
        return vc
    }
}

