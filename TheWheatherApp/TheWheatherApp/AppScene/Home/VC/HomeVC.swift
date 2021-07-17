//
//  HomeVC.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 14/7/21.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tblCities: UITableView!
    @IBOutlet weak var viewPlaceholder: UIView!

    
    var vm: HomeVmProtocol!{
        didSet{
            vm.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vm.getCities()
    }
    
    // MARK: - Setup
    private func setup(){
        tblCities.allowsMultipleSelectionDuringEditing = true
        registerXibs()
    }
    
    private func registerXibs(){
        tblCities.register(cell: CellCityWheather.self)
    }
    
    
    //MARK: - IBActions -
    @IBAction func actionShowUserLocation(_ sender: UIButton){
        self.navigationController?.pushViewController(UserLocRouter.make(), animated: true)
    }
    
    @IBAction func actionEdit(_ sender: UIButton){
        tblCities.isEditing = true
    }
    
    @IBAction func actionAdd(_ sender: UIButton){
        self.navigationController?.pushViewController(UserLocRouter.make(), animated: true)
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

extension HomeVC: HomeVmOutputDelegate{
    func userLocListLoaded() {
        viewPlaceholder.isHidden = (vm.arrLocs.count > 0)
        tblCities.reloadData()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.arrLocs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellCityWheather") as! CellCityWheather
        cell.configureCell(vm.arrLocs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      let delete = deleteProperty(at: indexPath)
      return UISwipeActionsConfiguration(actions: [delete])
    }

    // Declare this method in UIViewController Main and modify according to your need

    func deleteProperty(at indexpath: IndexPath) -> UIContextualAction {
      let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completon) in
//        self.yourArray.remove(at: indexpath) // Removing from array at selected index

        completon(true)
        action.backgroundColor = .red //cell background color
      }
      return action
    }
}
