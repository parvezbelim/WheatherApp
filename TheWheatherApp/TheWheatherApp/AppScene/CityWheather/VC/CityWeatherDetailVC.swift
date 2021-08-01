//
//  CityWeatherDetailVC.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 18/7/21.
//

import UIKit

class CityWeatherDetailVC: UIViewController {
    @IBOutlet weak var tblWeatherData: UITableView!
    var vm: CityWeatherVMProtocol!{
        didSet{
            vm.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        vm.getCityWeatherDetail()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CityWeatherDetailVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.arrWeatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellCityWeatherForcast", for: indexPath) as? CellCityWeatherForcast else {
            return UITableViewCell()
        }
        cell.configureCell(vm.arrWeatherData[indexPath.row])
        return cell
    }
}

extension CityWeatherDetailVC: CityWeatherOutputDelegate{
    func cityWheatherLoaded() {
        tblWeatherData.reloadData()
    }
}
