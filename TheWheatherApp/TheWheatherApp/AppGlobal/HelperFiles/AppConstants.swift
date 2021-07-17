import Foundation
import UIKit


let BASE_URL = "https://api.openweathermap.org/data/2.5/weather?"
let APPNAME = "Wheather App"
let KEY_WHEATHERAPI = "2f4904204d29852cb67e6342d43d8a90"

//GLOBAL Shared File Object
let AppdelegateObj =  UIApplication.shared.delegate as? AppDelegate

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

