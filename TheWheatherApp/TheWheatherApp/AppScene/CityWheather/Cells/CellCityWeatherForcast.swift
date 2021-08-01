//
//  CellCityWeatherForcast.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 19/7/21.
//

import UIKit

class CellCityWeatherForcast: UITableViewCell {
    @IBOutlet weak var lblWeatherDescription: UILabel!
    @IBOutlet weak var imgIconWeather: UIImageView!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ weatherData: CityForcastVMModel){
        lblTemperature.text = "\(weatherData.temp) C"
        lblHumidity.text = "\(weatherData.humidity)"
        lblWind.text = "\(weatherData.wind.speed)"
        lblWeatherDescription.text = "\(weatherData.desc)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
