//
//  HomeVM.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 15/7/21.
//

import Foundation

class HomeVM: HomeVmProtocol{
    var delegate: HomeVmOutputDelegate?
    var arrLocs = [UserCurrLocVMModel]()
    private var objCityUseCase: CityRecordsUseCase!

    init(_ cityUseCase: CityRecordsUseCase){
        self.objCityUseCase = cityUseCase
    }
    
    func getCities(){
        objCityUseCase.getCityList { arrCurrLocs in
            guard let arrLocs = arrCurrLocs else { return }
            self.arrLocs = arrLocs
            self.delegate?.userLocListLoaded()
        }
    }
}
