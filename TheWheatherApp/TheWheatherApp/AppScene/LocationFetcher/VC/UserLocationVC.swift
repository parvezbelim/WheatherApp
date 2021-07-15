//
//  UserLocationVC.swift
//  TheWheatherApp
//
//  Created by Parvez Belim on 15/7/21.
//

import UIKit
import MapKit

class UserLocationVC: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    private var isInitialLoad = true

    override func viewDidLoad() {
        super.viewDidLoad()
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

//MARK: - Taxi List Delegate -
extension UserLocationVC: MKMapViewDelegate, CLLocationManagerDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if let userLocation = annotation as? MKUserLocation{
            userLocation.title = "My Location"
            return nil
        }
        let reuseIdentifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseIdentifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

//        annotationView?.image = UIImage(named: "taxiMapIcon")

        return annotationView
    }
    
    //@@@@@@@ Toggle live and static envirnment @@@@@@@@@@
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLoction: CLLocation = locations.first,isInitialLoad{
            print(userLoction)
            isInitialLoad = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}

