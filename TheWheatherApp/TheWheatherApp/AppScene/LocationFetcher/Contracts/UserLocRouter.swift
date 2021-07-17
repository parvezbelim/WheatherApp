//
//  UserLocRouter.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 16/7/21.
//

import Foundation
import UIKit

final class UserLocRouter{
    static func make() -> UserLocationVC{
        let vc: UserLocationVC = UIStoryboard.load(.main, with: "UserLocationVC")
        vc.vm = UserLocationVM(CityRecodsDBOperations())
        return vc
    }
}
