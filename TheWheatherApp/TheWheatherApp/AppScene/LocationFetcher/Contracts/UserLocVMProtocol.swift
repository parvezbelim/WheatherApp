//
//  UserLocVMProtocol.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 16/7/21.
//

import Foundation

protocol UserLocVMProtocol: AnyObject {
    
    var delegate: UserLocOutputDelegate? { get set}
    
    func getWheatherForUserLoc(lat:Double,long:Double)
    func saveUserCurrLocation()
}


