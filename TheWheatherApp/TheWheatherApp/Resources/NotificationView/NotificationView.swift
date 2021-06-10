//
//  NotificationView.swift
//   
//
//  Created by  on 14/10/2019.
//  Copyright © 2019 . All rights reserved.
//

import UIKit

class NotificationView: UIView,UIGestureRecognizerDelegate {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblTextMessage: UILabel!
    @IBOutlet var viewBG: UIView!
    let heightNotif: Int = 90
    
    override func awakeFromNib(){
        let swipeGesture : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.hideNavigationView))
        swipeGesture.direction = .up
        self.addGestureRecognizer(swipeGesture)
        
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.navigateUser))
        tapGesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapGesture)
    }
    
    class func setup() -> NotificationView{
        if let view = MainWindow.viewWithTag(78787878){
            view.removeFromSuperview()
        }
        var CustomPushView : NotificationView! = NotificationView()
        CustomPushView = Bundle.main.loadNibNamed("NotificationView", owner: self, options: nil)![0] as? NotificationView
        CustomPushView.frame = CGRect(x: MainWindow.frame.origin.x, y:-90,width: (MainWindow.frame.width), height: 90)
        CustomPushView.tag = 78787878
        MainWindow.addSubview(CustomPushView)
        return CustomPushView
    }
    
    @objc func navigateUser() {
//        navigationController.pushViewController(objVC, animated: true)
        self.hideNavigationView()
    }
    
    @IBAction func actionClose(sender: UIButton){
        self.hideNavigationView()
    }
    
    func showMsgView(_ strMessage : String?,title : String?,bgColor: UIColor?)
    {
        self.frame = CGRect(x: (MainWindow.frame.origin.x) + 10, y:-90,width:MainWindow.frame.width - 20, height:90)
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.hideNavigationView), object: nil)
        self.perform(#selector(self.hideNavigationView), with: nil, afterDelay: 8.0)

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .allowUserInteraction, animations: {
                var topPadding:CGFloat
                topPadding = 0
                if #available(iOS 11, *) {
                    topPadding = MainWindow.safeAreaInsets.top
                }
                self.frame.origin.y = topPadding
            }, completion: { (done) in
        })
        
        MainWindow.bringSubviewToFront(self)
      
        if bgColor != nil{
            self.viewBG.backgroundColor = bgColor
        }

        if let strTitle = title, !strTitle.isEmpty{
            lblTitle.isHidden = false
            self.lblTitle.text = strTitle
        }
        
        self.lblTextMessage.text = strMessage
        self.isHidden = false
    }
    

    @objc func hideNavigationView() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.hideNavigationView), object: nil)
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .allowUserInteraction, animations: {
            self.frame.origin.y = -90
            }, completion: { (done) in
                self.isHidden = true
        })
    }
}
