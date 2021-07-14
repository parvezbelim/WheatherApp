//
//  TaxiListVC.swift
//  MyTaxi
//
//  Created by Parvez Belim on 5/12/20.
//

import UIKit

extension UIStoryboard {
    static func load<T: UIViewController>(_ name: StoryboardName) -> T {
        return UIStoryboard(name: name.rawValue, bundle: nil).instantiateInitialViewController() as! T
    }
    
    static func load<T: UIViewController>(_ name: StoryboardName, with identifier: String) -> T {
        return UIStoryboard(name: name.rawValue, bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as! T
    }
}
