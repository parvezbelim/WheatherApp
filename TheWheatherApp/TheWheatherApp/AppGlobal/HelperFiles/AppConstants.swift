import Foundation
import UIKit

let APPNAME = "MyTaxi"

let BASE_URL = "https://poi-api.mytaxi.com/"

//GLOBAL Shared File Object
let AppdelegateObj:AppDelegate =  UIApplication.shared.delegate as! AppDelegate

//MESSAGEs
let ALERTSERVERNOTRESPONDING = "Server not responding, Please try again"
let ALERTINTERNETCONNECTION = "It appears you do not have internet connection!"
let ALERTSOMETHINGWENTWRONG = "Something went wrong"


enum StoryBoardType: Int{
    case MAIN
}
enum StoryboardName: String {
    case splash = "Splash"
    case main = "Main"
}

