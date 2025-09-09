
import UIKit

class SignatureView: UIView {
    
    private var path = UIBezierPath()
    private var previousPoint: CGPoint!
    private var previousMidPoint: CGPoint!
    
    private let borderLayer = CAShapeLayer()
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
        
        // Path setup
        path.lineWidth = 2.0
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8).cgPath
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            previousPoint = point
            previousMidPoint = point
            
            hasSignature = true
            borderLayer.strokeColor = #colorLiteral(red: 0.1960784314, green: 0.8039215686, blue: 0.03807460484, alpha: 1).cgColor
            
            path.move(to: point)
            self.findParentTableView()?.isScrollEnabled = false
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            
            // Midpoint nikal ke quadratic curve draw karo
            let midPoint = CGPoint(x: (previousPoint.x + currentPoint.x) / 2,
                                   y: (previousPoint.y + currentPoint.y) / 2)
            
            path.addQuadCurve(to: midPoint, controlPoint: previousPoint)
            
            previousPoint = currentPoint
            previousMidPoint = midPoint
            
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.findParentTableView()?.isScrollEnabled = true
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
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
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let signatureImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return signatureImage ?? UIImage()
    }
    
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
