import UIKit

class ValidationLabel: UILabel {
    
    private var padding: UIEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    
    init() {
        super.init(frame: .zero)
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    private func setupLabel() {
        self.textColor = .black
        self.backgroundColor = .systemRed
        self.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
        self.isHidden = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
    
    func showMessage(_ message: String, color: UIColor = .systemRed) {
        self.text = message
        self.backgroundColor = color
        self.isHidden = false
        self.alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    func hideMessage() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        } completion: { _ in
            self.isHidden = true
        }
    }
}
