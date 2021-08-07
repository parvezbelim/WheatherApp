//
//  HomeVmProtocol.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 15/7/21.
//

import Foundation

protocol HomeVmProtocol: AnyObject {
    var delegate: HomeVmOutputDelegate? { get set}
    var arrLocs: [UserCurrLocVMModel] {get set}
    func getCities()
    func removeCity(_ name: String)
}


