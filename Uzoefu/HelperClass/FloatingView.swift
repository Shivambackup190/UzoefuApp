import UIKit

class FloatingSignatureView: UIView {
    
    private let borderLayer = CAShapeLayer()
    private let floatingLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Border
        borderLayer.strokeColor = UIColor.lightGray.cgColor
        borderLayer.lineWidth = 1.0
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
        layer.addSublayer(borderLayer)
        
        // Floating Label
//        floatingLabel.text = "Signatjnhjfvbjcdhbjhfgjure"
        floatingLabel.font = UIFont.systemFont(ofSize: 14)
        floatingLabel.textColor = UIColor.lightGray
        floatingLabel.backgroundColor = .white
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(floatingLabel)
        
        NSLayoutConstraint.activate([
            floatingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            floatingLabel.topAnchor.constraint(equalTo: topAnchor, constant: -10)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 8).cgPath
    }
}
