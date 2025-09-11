//
//  SearchRatingCell.swift
//  Uzoefu
//
//  Created by Narendra Kumar on 10/09/25.
//

import UIKit

class SearchRatingCell: UITableViewCell {
    
  
    let checkboxButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(systemName: "square"), for: .normal)          // unchecked
        btn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected) // checked
        btn.tintColor = .systemGreen
        return btn
    }()
    
 
    let ratingLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textColor = .black
        return lbl
    }()
    
   
    let starsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 4
        return sv
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
        contentView.addSubview(ratingLabel)
        contentView.addSubview(starsStackView)
        
        // AutoLayout
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        starsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkboxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            checkboxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 24),
            checkboxButton.heightAnchor.constraint(equalToConstant: 24),
            
            ratingLabel.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 12),
            ratingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            starsStackView.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 8),
            starsStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            starsStackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    // MARK: - Configure Cell
    func configure(with text: String, isSelected: Bool) {
        checkboxButton.isSelected = isSelected
        ratingLabel.text = text
        
        if let rating = Int(text) {
            // Show stars
            starsStackView.isHidden = false
            setRating(rating)
        } else {
            // "All ratings" case
            starsStackView.isHidden = true
        }
    }
    
   
    func setRating(_ rating: Int) {
        starsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for i in 1...5 {
            let star = UIImageView()
            star.image = UIImage(systemName: i <= rating ? "star.fill" : "star")
            star.tintColor = .gray
            starsStackView.addArrangedSubview(star)
        }
    }
}
