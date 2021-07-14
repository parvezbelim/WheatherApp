//
//  HomeVC.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 14/7/21.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tblCities: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       registerXibs()
    }
    
    // MARK: - Setup
    private func registerXibs(){
        tblCities.register(cell: CellCityWheather.self)
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

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCityWheather") as! CellCityWheather
        return cell
    }
}
