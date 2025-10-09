//
//  Designable.swift
//  WhoShoot


import Foundation
import UIKit

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableImageView: UIImageView {
}

@IBDesignable
class DesignableLabel: UILabel {
}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
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
    
    func fadeIn() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)
        
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 8.0, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }
    
    /// get nib from bundle
    static var nib: UINib {
        let nibName = nibFileExists(identifier) ? identifier : ""
        return UINib(nibName: nibName, bundle: Bundle(for: self))
    }

    private static func nibFileExists(_ nibName: String) -> Bool {
        Bundle(for: self).path(forResource: nibName, ofType: "nib") != nil
    }
    
    @discardableResult
    func fromNib<T: UIView>(named name: String? = nil) -> T? {
        let bundle = Bundle(for: type(of: self))
        let unwrappedName = name ?? String(describing: type(of: self))
        if Self.nibFileExists(unwrappedName),
           let content = bundle.loadNibNamed(unwrappedName, owner: self, options: nil)?.first as? T {
            return addView(content)
        }
        return nil
    }
    
    func addView<T: UIView>(_ contentView: T) -> T {
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layoutAttach(to: self)
        return contentView
    }
    
    func layoutAttach(to parentView: UIView, xPos: CGFloat, width: CGFloat) {
        // self.translatesAutoresizingMaskIntoConstraints = false
        parentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        parentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: -xPos).isActive = true
        parentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        parentView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
    }

    func layoutAttach(to parentView: UIView, height: CGFloat? = nil, inset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        parentView.topAnchor.constraint(equalTo: self.topAnchor, constant: inset).isActive = true
        parentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset).isActive = true
        parentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset).isActive = true
        parentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset).isActive = true

        guard let height = height else { return }
        let heightConstraint = heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        heightConstraint.priority = UILayoutPriority(rawValue: 900)
        heightConstraint.isActive = true
    }

    func layoutAttach(to parentView: UIView, inset: UIEdgeInsets) {
        self.translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: inset.left).isActive = true
        heightAnchor.constraint(equalTo: parentView.heightAnchor, multiplier: 1.0).isActive = true
        widthAnchor.constraint(equalTo: parentView.widthAnchor, multiplier: 1.0).isActive = true
    }
}

extension UIViewController {
   
    func applyGradientToViews(view:UIView) {
        view.layoutIfNeeded()
         var firstGradientLayer: CAGradientLayer?
        // Remove previous gradients if they exist
        firstGradientLayer?.removeFromSuperlayer()
        
        // First View Gradient
        let newFirstGradientLayer = CAGradientLayer()
        newFirstGradientLayer.frame = view.bounds // Make sure bounds are updated
        newFirstGradientLayer.colors = [
            UIColor(red: 0.899, green: 0.758, blue: 0.524, alpha: 1).cgColor,
            UIColor(red: 0.612, green: 0.471, blue: 0.231, alpha: 1).cgColor
        ]

        newFirstGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        newFirstGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        view.layer.insertSublayer(newFirstGradientLayer, at: 0)
        firstGradientLayer = newFirstGradientLayer
    }
    
    
    func applyGradientToButton(btn:UIButton) {
        view.layoutIfNeeded()
         var firstGradientLayer: CAGradientLayer?
        // Remove previous gradients if they exist
        firstGradientLayer?.removeFromSuperlayer()
        
        // First View Gradient
        let newFirstGradientLayer = CAGradientLayer()
        newFirstGradientLayer.frame = btn.bounds // Make sure bounds are updated
        newFirstGradientLayer.colors = [
            UIColor(red: 0.899, green: 0.758, blue: 0.524, alpha: 1).cgColor,
            UIColor(red: 0.612, green: 0.471, blue: 0.231, alpha: 1).cgColor
        ]

        newFirstGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        newFirstGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        btn.layer.insertSublayer(newFirstGradientLayer, at: 0)
        firstGradientLayer = newFirstGradientLayer
    }
    
    
    
    
}
public protocol Identifiable {
    static var identifier: String { get }
}

extension UIResponder: Identifiable {

    public static var identifier: String { String(describing: self) }
}

// email validation
extension String {
    
        func isValidEmail() -> Bool {
            let REGEX_USER_EMAIL = "[A-Z0-9a-z._%+-]{2,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
            let regex = try! NSRegularExpression(pattern: REGEX_USER_EMAIL,options: .caseInsensitive)
            return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
        }
    
}
//extension UITextField {
//    func addValidationLabel() -> ValidationLabel {
//        let label = ValidationLabel()
//        guard let superview = self.superview else { return label }
//
//        superview.addSubview(label)
//
//        NSLayoutConstraint.activate([
//            label.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 4),
//            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            label.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
//        ])
//
//        return label
//    }
//}


extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
/*
 use
 let customColor = UIColor(hex: "#60686B")
 cell.activity_price.textColor = customColor
 #colorLiteral(red: 0.4512393475, green: 0.4832214117, blue: 0.4951165318, alpha: 1) // #60686B
 */


extension UILabel {
    
    /// Sets price label in "from R200" style
    func setPriceText(price: String, currencySymbol: String = "R") {
        let fullText = "from \(currencySymbol)\(price)"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Price part (HelveticaNeue-Bold, size 16, custom color)
        if let range = fullText.range(of: "\(currencySymbol)\(price)") {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(
                .font,
                value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,
                range: nsRange
            )
            attributedString.addAttribute(
                .foregroundColor,
                value: #colorLiteral(red: 0.376, green: 0.408, blue: 0.420, alpha: 1), // #60686B
                range: nsRange
            )
        }
        
        // "from" part (grey, normal font)
        if let range = fullText.range(of: "from") {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(
                .font,
                value: UIFont.systemFont(ofSize: 14),
                range: nsRange
            )
            attributedString.addAttribute(
                .foregroundColor,
                value:#colorLiteral(red: 0.4512393475, green: 0.4832214117, blue: 0.4951165318, alpha: 1), // #60686B // light gray
                range: nsRange
            )
        }
        
        self.attributedText = attributedString
    }
    
    
    /// Sets today hours label in "Open · 25 mins" style
    func setTodayHoursText(hours: String?) {
        guard let hours = hours, !hours.isEmpty else {
            self.text = "Closed"
          //  self.textColor =  colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) // red
            self.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
            return
        }
        
        let fullText = "Open · \(hours)"
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // "Open" part (green & bold)
        if let range = fullText.range(of: "Open") {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(
                .font,
                value: UIFont.boldSystemFont(ofSize: self.font.pointSize),
                range: nsRange
            )
            attributedString.addAttribute(
                .foregroundColor,
                value: #colorLiteral(red: 0.0, green: 0.6, blue: 0.0, alpha: 1), // green
                range: nsRange
            )
        }
        
        // Hours part (normal gray)
        if let range = fullText.range(of: hours) {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(
                .font,
                value: UIFont.systemFont(ofSize: self.font.pointSize),
                range: nsRange
            )
            attributedString.addAttribute(
                .foregroundColor,
                value: #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), // dark gray
                range: nsRange
            )
        }
        
        self.attributedText = attributedString
    }
}

