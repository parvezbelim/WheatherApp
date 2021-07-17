//
//  CellCityWheather.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 14/7/21.
//

import UIKit

class CellCityWheather: UITableViewCell {
    @IBOutlet weak var lblCities: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ objCurrLoc: UserCurrLocVMModel){
        lblCities.text = objCurrLoc.cityName
    }

}
