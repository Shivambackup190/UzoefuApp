//import UIKit
//
//class FloatingTextField: UITextField {
//
//    private let floatingLabel = UILabel()
//    private var isLabelFloated = false
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup()
//    }
//    
//    private func setup() {
//        // Placeholder ko label banayenge
//        floatingLabel.text = placeholder
//        floatingLabel.font = UIFont.systemFont(ofSize: 14)
//        floatingLabel.textColor = .gray
//        floatingLabel.alpha = 0.0
//        addSubview(floatingLabel)
//        
//        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
//            floatingLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: -2)
//        ])
//        
//        self.delegate = self
//    }
//    
//    private func floatLabel() {
//        guard !isLabelFloated else { return }
//        isLabelFloated = true
//        UIView.animate(withDuration: 0.3) {
//            self.floatingLabel.alpha = 1.0
//        }
//    }
//    
//    private func hideLabel() {
//        guard isLabelFloated else { return }
//        if text?.isEmpty ?? true {
//            isLabelFloated = false
//            UIView.animate(withDuration: 0.3) {
//                self.floatingLabel.alpha = 0.0
//            }
//        }
//    }
//}
//
//extension FloatingTextField: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        floatLabel()
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        hideLabel()
//    }
//}
//import UIKit
//
//class FloatingTextField: UITextField {
//    
//    private let floatingLabel = UILabel()
//    private let borderLayer = CAShapeLayer()
//    private var isLabelFloated = false
//    
//    private let padding = UIEdgeInsets(top: 16, left: 8, bottom: 12, right: 8)
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup()
//    }
//    
//    private func setup() {
//        borderStyle = .none
//        backgroundColor = .clear
//        
//        // Draw outline border
//        layer.addSublayer(borderLayer)
//        borderLayer.strokeColor = UIColor.systemGreen.cgColor
//        borderLayer.fillColor = UIColor.clear.cgColor
//        borderLayer.lineWidth = 1.2
//        borderLayer.cornerRadius = 8
//        
//        // Floating Label
//        floatingLabel.text = placeholder
//        floatingLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
//        floatingLabel.textColor = UIColor.systemGreen
//        floatingLabel.backgroundColor = superview?.backgroundColor ?? .systemGroupedBackground
//        floatingLabel.alpha = 0.0
//        addSubview(floatingLabel)
//        
//        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
//            floatingLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 10)
//        ])
//        
//        delegate = self
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 8)
//        borderLayer.path = path.cgPath
//    }
//    
//    private func floatLabel() {
//        guard !isLabelFloated else { return }
//        isLabelFloated = true
//        UIView.animate(withDuration: 0.25) {
//            self.floatingLabel.alpha = 1.0
//            self.floatingLabel.transform = CGAffineTransform(translationX: 0, y: -4).scaledBy(x: 0.9, y: 0.9)
//        }
//    }
//    
//    private func hideLabel() {
//        guard isLabelFloated else { return }
//        if text?.isEmpty ?? true {
//            isLabelFloated = false
//            UIView.animate(withDuration: 0.25) {
//                self.floatingLabel.alpha = 0.0
//                self.floatingLabel.transform = .identity
//            }
//        }
//    }
//    
//    // Padding
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//}
//
//extension FloatingTextField: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        floatLabel()
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        hideLabel()
//    }
//}
//import UIKit
//
//class FloatingTextField: UITextField {
//    
//    private let floatingLabel = UILabel()
//    private let borderLayer = CAShapeLayer()
//    private var isLabelFloated = false
//    
//    private let padding = UIEdgeInsets(top: 16, left: 8, bottom: 12, right: 8)
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setup()
//    }
//    
//    private func setup() {
//        borderStyle = .none
//        backgroundColor = .clear
//        
//        // 🔹 Outline border (start hidden)
//        layer.addSublayer(borderLayer)
//        borderLayer.strokeColor = UIColor.systemGreen.cgColor
//        borderLayer.fillColor = UIColor.clear.cgColor
//        borderLayer.lineWidth = 1.2
//        borderLayer.cornerRadius = 8
//        borderLayer.opacity = 0.0   // hidden initially
//        
//        // 🔹 Floating Label
//        floatingLabel.text = placeholder
//        floatingLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
//        floatingLabel.textColor = UIColor.systemGreen
//        floatingLabel.backgroundColor = .systemBackground // match screen bg
//        floatingLabel.alpha = 0.0
//        addSubview(floatingLabel)
//        
//        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
//            floatingLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 12)
//        ])
//        
//        delegate = self
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 8)
//        borderLayer.path = path.cgPath
//    }
//    
//    private func floatLabel() {
//        guard !isLabelFloated else { return }
//        isLabelFloated = true
//        UIView.animate(withDuration: 0.25) {
//            self.floatingLabel.alpha = 1.0
//            self.floatingLabel.transform = CGAffineTransform(translationX: 0, y: -6).scaledBy(x: 0.9, y: 0.9)
//            self.borderLayer.opacity = 1.0   // border show
//        }
//    }
//    
//    private func hideLabel() {
//        guard isLabelFloated else { return }
//        
//        if text?.isEmpty ?? true {
//            isLabelFloated = false
//            UIView.animate(withDuration: 0.25) {
//                self.floatingLabel.alpha = 0.0
//                self.floatingLabel.transform = .identity
//                self.borderLayer.opacity = 0.0   // border hide
//            }
//        } else {
//            borderLayer.opacity = 1.0 // text hai toh border rahega
//        }
//    }
//    
//    // Padding
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: padding)
//    }
//}
//
//extension FloatingTextField: UITextFieldDelegate {
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        floatLabel()
//    }
//    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        hideLabel()
//    }
//}
import UIKit

class FloatingTextField: UITextField,UITextFieldDelegate {
    weak var forwardDelegate: UITextFieldDelegate?//newline
    private let floatingLabel = UILabel()
    private let borderLayer = CAShapeLayer()
    private var isLabelFloated = false
    
    private let padding = UIEdgeInsets(top: 16, left: 8, bottom: 12, right: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
                setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        delegate = self
                setup()
    }
    
    private func setup() {
        borderStyle = .none
        backgroundColor = .clear
        
        // 🔹 Outline border (default gray)
        layer.addSublayer(borderLayer)
        borderLayer.strokeColor = UIColor.lightGray.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 1.2
        borderLayer.cornerRadius = 6
        borderLayer.opacity = 1.0   // hamesha visible square
        
        // 🔹 Floating Label
        floatingLabel.text = placeholder
        floatingLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        floatingLabel.textColor = UIColor.systemGreen
        floatingLabel.backgroundColor = .systemBackground // background match
        floatingLabel.alpha = 0.0
        addSubview(floatingLabel)
        
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            floatingLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 12)
        ])
        
        delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: 6)
        borderLayer.path = path.cgPath
    }
    
    private func floatLabel() {
        guard !isLabelFloated else { return }
        isLabelFloated = true
        UIView.animate(withDuration: 0.25) {
            self.floatingLabel.alpha = 1.0
            self.floatingLabel.transform = CGAffineTransform(translationX: 0, y: -6).scaledBy(x: 0.9, y: 0.9)
            self.borderLayer.strokeColor = UIColor.systemGreen.cgColor // 🔹 green on focus
        }
    }
    
    private func hideLabel() {
        if text?.isEmpty ?? true {
            // Empty -> label andar + gray border
            isLabelFloated = false
            UIView.animate(withDuration: 0.25) {
                self.floatingLabel.alpha = 0.0
                self.floatingLabel.transform = .identity
                self.borderLayer.strokeColor = UIColor.lightGray.cgColor
            }
        } else {
            // Text hai -> label upar + gray border
            UIView.animate(withDuration: 0.25) {
                self.floatingLabel.alpha = 1.0
                self.floatingLabel.transform = CGAffineTransform(translationX: 0, y: -6).scaledBy(x: 0.9, y: 0.9)
                self.borderLayer.strokeColor = UIColor.lightGray.cgColor
            }
        }
    }
    
    // Padding
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension FloatingTextField {
    // MARK: - Delegate forwarding
       func textFieldDidBeginEditing(_ textField: UITextField) {
           floatLabel()
           layer.borderColor = UIColor.green.cgColor
           forwardDelegate?.textFieldDidBeginEditing?(textField)
       }

       func textFieldDidEndEditing(_ textField: UITextField) {
           hideLabel()
           forwardDelegate?.textFieldDidEndEditing?(textField)
       }
   }

