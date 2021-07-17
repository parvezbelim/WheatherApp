//
//  UserLocContracts.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 16/7/21.
//

import Foundation

protocol UserLocOutputDelegate: Any{
    func responseReceived(locDetail: UserCurrLocVMModel)
}
