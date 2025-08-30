
import UIKit

class SignatureView: UIView {
    
    private var path = UIBezierPath()
    private var previousPoint: CGPoint!
    
    private let floatingLabel = UILabel()   // Floating placeholder
    private let borderLayer = CAShapeLayer() // Border
    
    private var hasSignature = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        self.backgroundColor = .white
        self.isMultipleTouchEnabled = false
        
        // Border setup
        borderLayer.strokeColor = UIColor.lightGray.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 1.5
        borderLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8).cgPath
        self.layer.addSublayer(borderLayer)
        
        // Floating placeholder
        floatingLabel.text = "Signature"
        floatingLabel.textColor = .lightGray
        floatingLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(floatingLabel)
        
        NSLayoutConstraint.activate([
            floatingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            floatingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -8)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8).cgPath
    }
    
    // Start drawing
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            previousPoint = touch.location(in: self)
            hasSignature = true
            
            // Change border color when signing
            borderLayer.strokeColor = #colorLiteral(red: 0.1960784314, green: 0.8039215686, blue: 0.03807460484, alpha: 1).cgColor
            floatingLabel.textColor = #colorLiteral(red: 0.1960784314, green: 0.8039215686, blue: 0.03807460484, alpha: 1)
            
            self.findParentTableView()?.isScrollEnabled = false
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            path.move(to: previousPoint)
            path.addLine(to: currentPoint)
            previousPoint = currentPoint
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.findParentTableView()?.isScrollEnabled = true
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.black.setStroke()
        path.stroke()
    }
    
    func clear() {
        path.removeAllPoints()
        setNeedsDisplay()
        hasSignature = false
        borderLayer.strokeColor = UIColor.lightGray.cgColor
    }
    
    func getSignatureImage() -> UIImage {
        UIGraphicsBeginImageContext(self.bounds.size)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let signatureImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return signatureImage ?? UIImage()
    }
    
    // Helper: parent UITableView dhoondho
    private func findParentTableView() -> UITableView? {
        var view = self.superview
        while view != nil {
            if let tableView = view as? UITableView {
                return tableView
            }
            view = view?.superview
        }
        return nil
    }
}







//import UIKit
////ooriginal
//class SignatureView: UIView {
//    
//    private var path = UIBezierPath()
//    private var previousPoint: CGPoint!
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
//        self.backgroundColor = .white
//        self.isMultipleTouchEnabled = false
//    }
//    
//    // Start drawing
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            previousPoint = touch.location(in: self)
//            
//            // 🔴 disable parent scroll jab sign start ho
//            self.findParentTableView()?.isScrollEnabled = false
//        }
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let touch = touches.first {
//            let currentPoint = touch.location(in: self)
//            path.move(to: previousPoint)
//            path.addLine(to: currentPoint)
//            previousPoint = currentPoint
//            setNeedsDisplay()
//        }
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        // ✅ enable parent scroll back jab sign finish ho
//        self.findParentTableView()?.isScrollEnabled = true
//    }
//    
//    override func draw(_ rect: CGRect) {
//        UIColor.black.setStroke()
//        path.stroke()
//    }
//    
//    func clear() {
//        path.removeAllPoints()
//        setNeedsDisplay()
//    }
//    
//    func getSignatureImage() -> UIImage {
//        UIGraphicsBeginImageContext(self.bounds.size)
//        self.layer.render(in: UIGraphicsGetCurrentContext()!)
//        let signatureImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return signatureImage ?? UIImage()
//    }
//    
//    // 🟢 Helper: parent UITableView dhoondho
//    private func findParentTableView() -> UITableView? {
//        var view = self.superview
//        while view != nil {
//            if let tableView = view as? UITableView {
//                return tableView
//            }
//            view = view?.superview
//        }
//        return nil
//    }
//}
/*
 import UIKit

 class SignatureView: UIView, UIGestureRecognizerDelegate {
     
     private var path = UIBezierPath()
     private var previousPoint: CGPoint!
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         setup()
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
         setup()
     }
     
     private func setup() {
         self.backgroundColor = .white
         self.isMultipleTouchEnabled = false
         
         // 🟢 Gesture recognizer bas conflict avoid ke liye, koi action nahi lega
         let panBlocker = UIPanGestureRecognizer()
         panBlocker.delegate = self
         self.addGestureRecognizer(panBlocker)
     }
     
     // MARK: - Gesture Delegate
     func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                            shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
         // TableView ke pan gesture ke saath simultaneously recognize na ho
         return false
     }
     
     func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                            shouldReceive touch: UITouch) -> Bool {
         // ✅ Ensure ki ye panGesture kuch na kare
         return false
     }
     
     // MARK: - Touch Handling for Drawing
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
         if let touch = touches.first {
             previousPoint = touch.location(in: self)
         }
     }
     
     override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
         if let touch = touches.first {
             let currentPoint = touch.location(in: self)
             path.move(to: previousPoint)
             path.addLine(to: currentPoint)
             previousPoint = currentPoint
             setNeedsDisplay()
         }
     }
     
     override func draw(_ rect: CGRect) {
         UIColor.black.setStroke()
         path.lineWidth = 2
         path.lineCapStyle = .round
         path.stroke()
     }
     
     // MARK: - Public Helpers
     func clear() {
         path.removeAllPoints()
         setNeedsDisplay()
     }
     
     func getSignatureImage() -> UIImage {
         UIGraphicsBeginImageContext(self.bounds.size)
         self.layer.render(in: UIGraphicsGetCurrentContext()!)
         let signatureImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
         return signatureImage ?? UIImage()
     }
 }

 */
