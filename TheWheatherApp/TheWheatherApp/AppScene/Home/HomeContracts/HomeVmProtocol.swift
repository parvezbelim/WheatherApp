//
//  HomeVmProtocol.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 15/7/21.
//

import Foundation

protocol HomeVmProtocol: AnyObject {
    var delegate: HomeVmOutputDelegate? { get set}
}


