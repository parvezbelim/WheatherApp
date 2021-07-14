

import Foundation
import UIKit
import Photos
import MapKit

internal func InitCustom<Type>(_ value: Type, block: (_ object: Type) -> Void) -> Type {
    block(value)
    return value
}

extension CGAffineTransform {
    var scale: Double {
        return sqrt(Double(a * a + c * c))
    }
}

public extension NSObject {
    
    var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last!
    }
    
    class var className: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}


extension UITableView {
    
    func register<T: UITableViewHeaderFooterView>(headerFooterView classType: T.Type) {
        register(UINib(nibName: T.className, bundle: nil), forHeaderFooterViewReuseIdentifier: T.className)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for section: Int = 0) -> T? {
        let view = dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T
        view?.tag = section
        return view
    }
    
    func register<T: UITableViewHeaderFooterView>(headerFooterViewClass classType: T.Type) {
        register(classType, forHeaderFooterViewReuseIdentifier: T.className)
    }
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T
    }
    
    func register<T: UITableViewCell>(cell classType: T.Type) {
        register(UINib(nibName: T.className, bundle: nil), forCellReuseIdentifier: T.className)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.className, for: indexPath) as! T
    }
    
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        return dequeueReusableCell(withIdentifier: T.className) as! T
    }
}


class TableView: UITableView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
                
        if let hitView = super.hitTest(point, with: event) , hitView != self
        {
            return hitView
        }
        return nil
    }
}


extension UIView {

    static func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
    func dropShadowBottom(color: UIColor) {
        self.shadowColor = color
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
    }
    
    
    func findViewsOfClass<T:UIView>(viewClass: T.Type) -> [T] {
        var views: [T] = []
        for subview in subviews {
            if subview is T {
                views.append(subview as! T)
            }
            views.append(contentsOf: subview.findViewsOfClass(viewClass: T.self))
        }
        return views
    }
    
    
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    @IBInspectable public var cornerRadius: CGFloat{
        get{ return layer.cornerRadius}
        set{ return layer.cornerRadius = newValue}
    }
    
    @IBInspectable public var borderWidth: CGFloat{
        get{ return layer.borderWidth}
        set{ return layer.borderWidth = newValue}
    }
    
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }

}


extension URL {
    
    mutating func appendQueryItem(name: String, value: String?) {
        
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        
        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        
        // Create query item
        let queryItem = URLQueryItem(name: name, value: value)
        
        // Append the new query item in the existing query items array
        queryItems.append(queryItem)
        
        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems
        
        // Returns the url from new url components
        self = urlComponents.url!
    }
}




extension Array where Element: Hashable {
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
    
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}



extension Int64{
    func setUserDefaultString(key: String){
        UserDefaults.standard.setValue(self, forKey: key)
        UserDefaults.standard.synchronize()
    }
}


/* SCROLLVIEW */
extension UIScrollView {
    
    func makeAwareOfKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyBoardDidShow(notification: Notification) {
        let info = notification.userInfo as NSDictionary?
        let rectValue = info![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let kbSize = rectValue.cgRectValue.size
        
        let contentInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: kbSize.height + 15, right: 0)
        self.contentInset = contentInsets
        self.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyBoardDidHide(notification: Notification) {
        let contentInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        self.contentInset = contentInsets
        self.scrollIndicatorInsets = contentInsets
    }
}


extension BinaryInteger {
    var degreesToRadians: CGFloat { CGFloat(self) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { self * .pi / 180 }
    var radiansToDegrees: Self { self * 180 / .pi }
}

extension String {

    static func random(length: Int = 20) -> String {
        let base = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}

typealias Edges = (ne: CLLocationCoordinate2D, sw: CLLocationCoordinate2D)

extension MKMapView {
    func edgePoints() -> Edges {
          let nePoint = CGPoint(x: self.bounds.maxX, y: self.bounds.origin.y)
    let swPoint = CGPoint(x: self.bounds.minX, y: self.bounds.maxY)
    
    let neCoord = self.convert(nePoint, toCoordinateFrom: self)
    let swCoord = self.convert(swPoint, toCoordinateFrom: self)
    
    return (ne: neCoord, sw: swCoord)
    }
}


extension UISearchBar {
    
    func getTextField() -> UITextField? { return value(forKey: "searchField") as? UITextField }
    func set(textColor: UIColor) { if let textField = getTextField() { textField.textColor = textColor } }
    func setPlaceholder(textColor: UIColor) { getTextField()?.setPlaceholder(textColor: textColor) }
    func setClearButton(color: UIColor) { getTextField()?.setClearButton(color: color) }
    
    func setTextField(color: UIColor) {
        guard let textField = getTextField() else { return }
        switch searchBarStyle {
        case .minimal:
            textField.layer.backgroundColor = color.cgColor
            textField.layer.cornerRadius = 12
        //            var customHeight = textField.frame
        //            customHeight.size.height = 50
        //            self.frame = customHeight
        
        case .prominent, .default: textField.backgroundColor = color
        @unknown default: break
        }
    }
    
    func setSearchImage(color: UIColor) {
        guard let imageView = getTextField()?.leftView as? UIImageView else { return }
        imageView.tintColor = color
        imageView.image = UIImage(named: "serchBarIcon")?.withRenderingMode(.alwaysTemplate)
    }
}

private extension UITextField {
    
    private class Label: UILabel {
        private var _textColor = UIColor.lightGray
        override var textColor: UIColor! {
            set { super.textColor = _textColor }
            get { return _textColor }
        }
        
        init(label: UILabel, textColor: UIColor = .lightGray) {
            _textColor = textColor
            super.init(frame: label.frame)
            self.text = label.text
            self.font = label.font
        }
        
        required init?(coder: NSCoder) { super.init(coder: coder) }
    }
    
    
    private class ClearButtonImage {
        static private var _image: UIImage?
        static private var semaphore = DispatchSemaphore(value: 1)
        static func getImage(closure: @escaping (UIImage?)->()) {
            DispatchQueue.global(qos: .userInteractive).async {
                semaphore.wait()
                DispatchQueue.main.async {
                    if let image = _image { closure(image); semaphore.signal(); return }
                    guard let window = UIApplication.shared.windows.first else { semaphore.signal(); return }
                    let searchBar = UISearchBar(frame: CGRect(x: 0, y: -200, width: UIScreen.main.bounds.width, height: 44))
                    window.rootViewController?.view.addSubview(searchBar)
                    searchBar.text = "txt"
                    searchBar.layoutIfNeeded()
                    _image = searchBar.getTextField()?.getClearButton()?.image(for: .normal)
                    closure(_image)
                    searchBar.removeFromSuperview()
                    semaphore.signal()
                }
            }
        }
    }
    
    func setClearButton(color: UIColor) {
        ClearButtonImage.getImage { [weak self] image in
            guard   let image = image,
                    let button = self?.getClearButton() else { return }
            button.imageView?.tintColor = color
            button.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    var placeholderLabel: UILabel? { return value(forKey: "placeholderLabel") as? UILabel }
    
    func setPlaceholder(textColor: UIColor) {
        guard let placeholderLabel = placeholderLabel else { return }
        let label = Label(label: placeholderLabel, textColor: textColor)
        setValue(label, forKey: "placeholderLabel")
    }
    
    func getClearButton() -> UIButton? { return value(forKey: "clearButton") as? UIButton }
}


extension Double {
    
    /// Rounds the double to decimal places value
    mutating func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func removeZerosFromEnd(max : Int) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        print(self)
        if (self < 1.0 && self != 0) || self < 0.0{
            return "0\(String(format: "%.2f", self))"
        }
        else{
            return String(format: "%.2f", self)
        }
    }
    
    func removeZerosForRating() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        if self < 1.0 && self != 0{
            return "0\(String(format: "%.1f", self))"
        }
        else{
            return String(format: "%.1f", self)
        }
    }
    
    func removeZeroPercentageMde(max : Int) -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.maximumFractionDigits = max
        if self < 1.0 && self != 0{
            return "0\(String(formatter.string(from: number) ?? ""))"
        }
        else{
            return String(formatter.string(from: number) ?? "")
        }
    }
    
    var roundString:String {
        return String(format: "%.2f", self)
    }
    
    func removeAllZeros() -> String{
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.maximumFractionDigits = 0
        return String(formatter.string(from: number) ?? "")
    }
}

extension Data {
    private static let hexAlphabet = "0123456789abcdef".unicodeScalars.map { $0 }
    
    public func hexEncodedString() -> String {
        return String(self.reduce(into: "".unicodeScalars, { (result, value) in
            result.append(Data.hexAlphabet[Int(value/16)])
            result.append(Data.hexAlphabet[Int(value%16)])
        }))
    }
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}


extension Encodable {
    var asDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    
    func dictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}


