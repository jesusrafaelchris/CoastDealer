//
//  BookingCell.swift
//  KeyloopDealer
//
//  Created by Christian Grinling on 05/03/2022.
//

import UIKit

class BookingCell: UICollectionViewCell {
    
    let numberplatecolour = UIColor(hexString: "#F9D349")
    
    lazy var ServiceImage: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = 10
        imageview.layer.masksToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        //imageview.backgroundColor = UIColor(hexString: "F6F6F6")
        return imageview
    }()
    
    lazy var CustomerName: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 16, text: "", bold: true)
        return text
    }()
    
    lazy var NumberPlateText: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 12, text: "", bold: true)
        text.backgroundColor = numberplatecolour
        text.textAlignment = .center
        text.layer.cornerRadius = 4
        text.layer.masksToBounds = true
        return text
    }()
    
    lazy var ServiceName: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 14, text: "", bold: true)
        return text
    }()
    
    lazy var startTime: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 12, text: "", bold: true)
        text.backgroundColor = UIColor(hexString: "F6F6F6")
        text.layer.cornerRadius = 5
        text.layer.masksToBounds = true
        text.textAlignment = .center
        return text
    }()
    
    lazy var dash: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 14, text: "-", bold: true)
        text.textAlignment = .center
        return text
    }()
    
    lazy var endTime: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 12, text: "", bold: true)
        text.backgroundColor = UIColor(hexString: "F6F6F6")
        text.layer.cornerRadius = 5
        text.layer.masksToBounds = true
        text.textAlignment = .center
        return text
    }()
    
    func addTopAndBottomBorders() {
        let thickness: CGFloat = 2
       let topBorder = CALayer()
       let bottomBorder = CALayer()
       topBorder.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: thickness)
       topBorder.backgroundColor = UIColor(hexString: "F6F6F6").cgColor
        bottomBorder.frame = CGRect(x:0, y: self.frame.size.height - thickness, width: self.frame.size.width, height:thickness)
        bottomBorder.backgroundColor = UIColor(hexString: "F6F6F6").cgColor
       layer.addSublayer(topBorder)
       layer.addSublayer(bottomBorder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addTopAndBottomBorders()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        addSubview(ServiceImage)
        addSubview(CustomerName)
        addSubview(NumberPlateText)
        addSubview(ServiceName)
        addSubview(startTime)
        addSubview(dash)
        addSubview(endTime)
        
        ServiceImage.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: leftAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 40, height: 40)
        ServiceImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        CustomerName.anchor(top: topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: ServiceImage.rightAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0)
        //CustomerName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        NumberPlateText.anchor(top: CustomerName.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: ServiceImage.rightAnchor, paddingLeft: 10, right: nil, paddingRight: 0, width: 0, height: 0)
        NumberPlateText.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25).isActive = true
        NumberPlateText.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25).isActive = true
        
        ServiceName.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: rightAnchor, paddingRight: 5, width: 0, height: 0)
        ServiceName.centerYAnchor.constraint(equalTo: CustomerName.centerYAnchor).isActive = true
        
        
        startTime.anchor(top: ServiceName.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: dash.leftAnchor, paddingRight: 0, width: 50, height: 25)
        //startTime.centerYAnchor.constraint(equalTo: NumberPlateText.centerYAnchor).isActive = true
        
        dash.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: startTime.rightAnchor, paddingLeft: 2.5, right: nil, paddingRight: 5, width: 20, height: 20)
        dash.centerYAnchor.constraint(equalTo: startTime.centerYAnchor).isActive = true
        
        endTime.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: dash.rightAnchor, paddingLeft: 2.5, right: rightAnchor, paddingRight: 5, width: 50, height: 25)
        endTime.centerYAnchor.constraint(equalTo: startTime.centerYAnchor).isActive = true
        
    }
}
