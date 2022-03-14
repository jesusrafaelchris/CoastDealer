//
//  WeekCell.swift
//  KeyloopDealer
//
//  Created by Christian Grinling on 04/03/2022.
//

import UIKit

class WeekCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            dayView.backgroundColor = isSelected ? UIColor(hexString: "222222") : UIColor(hexString: "BDBDBD")
        }
    }
    
    lazy var dayView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(hexString: "BDBDBD")
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dayLabel: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 12, text: "day", bold: false)
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var heightConstraint: NSLayoutConstraint?
    var heightmult: NSLayoutConstraint?
    
    
    func setupView() {
        addSubview(dayView)
        addSubview(dayLabel)
        
        dayView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dayView.bottomAnchor.constraint(equalTo: dayLabel.topAnchor,constant: -20).isActive = true
        //dayView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        heightConstraint = dayView.heightAnchor.constraint(equalToConstant: 30)
        heightConstraint?.isActive = true
        dayView.widthAnchor.constraint(equalToConstant: 35).isActive = true

        
        dayLabel.anchor(top: nil, paddingTop: 20, bottom: bottomAnchor, paddingBottom: 5, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
}

