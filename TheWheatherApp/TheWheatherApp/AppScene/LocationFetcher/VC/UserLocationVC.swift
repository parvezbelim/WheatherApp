//
//  UserLocationVC.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 15/7/21.
//

import UIKit
import MapKit

class UserLocationVC: UIViewController {
    
    @IBOutlet weak var mapView: CustomMap!
    @IBOutlet weak var lblLocation: UILabel!
    
    private var isInitialLoad = true
    private let locationManager = CLLocationManager()
    private var locPin:LocationAnnotation!
    private var pinAnnotationView:MKPinAnnotationView!
    
    var vm: UserLocVMProtocol!{
        didSet{
            vm.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUserCurrenLocation()
    }
    
    private func setupUserCurrenLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = false
    }

    
    @IBAction func actionConfirmCity(_ sender: Any) {
        vm.saveUserCurrLocation()
        self.navigationController?.popViewController(animated: true)
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

extension UserLocationVC: UserLocOutputDelegate{
    func responseReceived(locDetail: UserCurrLocVMModel) {
        lblLocation.text = locDetail.cityName
    }
}

extension UserLocationVC: MKMapViewDelegate, CLLocationManagerDelegate{

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let coordinate = mapView.convert(mapView.center, toCoordinateFrom: mapView)
        vm.getWheatherForUserLoc(lat: coordinate.latitude, long: coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLoction: CLLocation = locations.first,isInitialLoad{
            mapView.setupMapRegionFor(location: userLoction)
            isInitialLoad = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

