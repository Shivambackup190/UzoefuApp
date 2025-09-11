//
//  PriceSearchCell.swift
//  Uzoefu
// without this calss table can handele
//  Created by Narendra Kumar on 11/09/25.
//
import UIKit

class PriceSearchCell: UITableViewCell {
    
  
    let checkboxButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "square"), for: .normal)          // unchecked
        btn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected) // checked
        btn.tintColor = .systemGreen
        return btn
    }()
    

    let priceLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .black
        return lbl
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        // Add subviews
        contentView.addSubview(checkboxButton)
        contentView.addSubview(priceLabel)
        
        // AutoLayout
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 24),
            checkboxButton.heightAnchor.constraint(equalToConstant: 24),
            
            priceLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 12),
            priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            priceLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Configure Cell
    func configure(with text: String, isSelected: Bool) {
        checkboxButton.isSelected = isSelected
        priceLabel.text = text
    }
}
