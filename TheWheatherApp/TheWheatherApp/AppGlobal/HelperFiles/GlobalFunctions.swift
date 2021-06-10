

import Foundation
import UIKit

fileprivate var completionAlert:(Bool)->() = {_ in }
fileprivate var completionAlertButtonIndex:(Int)->() = {_ in }


var CustomNotifAlert : NotificationView{
    return NotificationView.setup()
}


//MARK: - Utility Functions -
func setGradientForButton(_ btn: UIButton){
    let effect =  UIBlurEffect(style:.dark)
    let blur = UIVisualEffectView(effect:effect)
    blur.frame = btn.bounds
    blur.clipsToBounds = true
    blur.isUserInteractionEnabled = false
    btn.insertSubview(blur, at: 0)
    btn.isHidden = false
    if let imageView = btn.imageView {
        btn.bringSubviewToFront(imageView)
    }
}

func setGradientForButton(_ btn: UIButton, styleType: UIBlurEffect.Style){
    var effect =  UIBlurEffect(style:styleType)
    if #available(iOS 13.0, *) {
       effect = UIBlurEffect(style:styleType)
    }
    let blur = UIVisualEffectView(effect:effect)
    blur.frame = btn.bounds
    blur.clipsToBounds = true
//    blur.alpha = 0.99
    blur.isUserInteractionEnabled = false
    btn.insertSubview(blur, at: 0)
    btn.isHidden = false
    if let imageView = btn.imageView {
        btn.bringSubviewToFront(imageView)
    }
}

var MainWindow: UIWindow  {
    if #available(iOS 13, *) {
        if let window = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
            .filter({$0.isKeyWindow}).first{
            window.backgroundColor = .clear
            return window
        }
    }
    else if let window = UIApplication.shared.keyWindow{
        return window
    }
    return UIWindow()
}


func animationCloseWindow(for view: UIView, completion: @escaping ()->()){
   view.transform = .identity
   UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {() -> Void in
       view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
   }, completion: {(finished: Bool) -> Void in
        view.isHidden = true
        completion()
   })
}

func animationOpenWindow(for view: UIView, completion: @escaping ()->()){
    view.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
    view.isHidden = false
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {() -> Void in
           view.transform = .identity
       }, completion: {(finished: Bool) -> Void in
           completion()
       })
}

func showAlert(msg:String, title: String = "", bgcolor: UIColor = .white){
    CustomNotifAlert.showMsgView(msg, title: title, bgColor: bgcolor)
}

///Function completion return true if Ok button is pressed else false
func showAlertController(vc: UIViewController, msg:String,title:String = "",btnOkTitle: String,btnCancelTitle: String,completion:@escaping (Bool) ->()){
    completionAlert = completion
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: btnCancelTitle, style: .default, handler: { action in
           completionAlert(false)
          }))
    
    alert.addAction(UIAlertAction(title: btnOkTitle, style: .default, handler: { action in
        completionAlert(true)
       }))
    
    vc.present(alert, animated: true, completion: nil)
}

func showAlertControllerWithMultipleButtons(vc: UIViewController, msg:String,title:String = "",btnTitles:[String],completion:@escaping (Int) ->()){
    completionAlertButtonIndex = completion
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    
    for (index,strTitle) in btnTitles.enumerated(){
        alert.addAction(UIAlertAction(title: strTitle, style: .default, handler: { action in
            completionAlertButtonIndex(index)
              }))
    }
    vc.present(alert, animated: true, completion: nil)
}

func showAlertController(vc: UIViewController, msg:String,title:String = "",btnOkTitle: String,completion:@escaping (Bool) ->()){
    completionAlert = completion
    let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: btnOkTitle, style: .default, handler: { action in
        completionAlert(true)
       }))
    
    vc.present(alert, animated: true, completion: nil)
}

func getStoryBoard(storyboard: StoryboardName) -> UIStoryboard{
    return UIStoryboard(name: storyboard.rawValue, bundle: nil)
}

func constrainViewEqual(holderView: UIView, view: UIView) {
    view.translatesAutoresizingMaskIntoConstraints = false

    let pinTop = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
                                    toItem: holderView, attribute: .top, multiplier: 1.0, constant:0 )
    let pinBottom = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
                                       toItem: holderView, attribute: .bottom, multiplier: 1.0, constant: 0)
    let pinLeft = NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal,
                                     toItem: holderView, attribute: .left, multiplier: 1.0, constant: 0)
    let pinRight = NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal,
                                      toItem: holderView, attribute: .right, multiplier: 1.0, constant: 0)
    
    holderView.addConstraints([pinTop, pinBottom, pinLeft, pinRight])
}

