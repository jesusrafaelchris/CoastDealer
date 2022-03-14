//
//  RecieveCar.swift
//  KeyloopDealer
//
//  Created by Christian Grinling on 05/03/2022.
//

import Firebase
import UIKit
import Foundation

class RecieveCar: UIViewController {
    
    var name:String?
    var numberplate: String?
    let numberplatecolour = UIColor(hexString: "#F9D349")
    
    lazy var carImage: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = 10
        imageview.layer.masksToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "recieved")
        return imageview
    }()
    
    lazy var checkinwaittext: UILabel = {
        let text = UILabel()
        if let name = name {
            text.layout(colour: .black, size: 20, text: "Scan \(name)'s numberplate \n to confirm", bold: true)
        }
        text.numberOfLines = 0
        text.textAlignment = .center
        return text
    }()
    
    lazy var NumberPlateText: UILabel = {
        let text = UILabel()
        if let numberplate = numberplate {
            text.layout(colour: .black, size: 18, text: numberplate, bold: true)
        }
        text.backgroundColor = numberplatecolour
        text.textAlignment = .center
        text.layer.cornerRadius = 4
        text.layer.masksToBounds = true
        return text
    }()
    
    let donebutton = darkblackbutton.textstring(text: "Scan")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .white
        donebutton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    var id: String?
    
    @objc func dismissView() {
        guard let id = id else {return}
        let trackingref = Firestore.firestore().collection("userbookings").document(id)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = Date()
        let timeString = dateFormatter.string(from: date)
        trackingref.setData(["recieved":true, "reviewed":false, "recievedTime": timeString], merge:true)
        self.dismiss(animated: true, completion: nil)
    }

    func setupView() {
        view.addSubview(carImage)
        view.addSubview(checkinwaittext)
        view.addSubview(NumberPlateText)
        view.addSubview(donebutton)
        
        carImage.anchor(top: nil, paddingTop: 0, bottom: view.centerYAnchor, paddingBottom: 0, left: nil, paddingLeft: 20, right: nil, paddingRight: 20, width: 0, height: 0)
        carImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        carImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true
        carImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        
        checkinwaittext.anchor(top: carImage.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 40, right: nil, paddingRight: 40, width: 0, height: 0)
        checkinwaittext.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkinwaittext.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true

        NumberPlateText.anchor(top: checkinwaittext.bottomAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 40, right: nil, paddingRight: 40, width: 0, height: 35)
        NumberPlateText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NumberPlateText.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true

        donebutton.anchor(top: nil, paddingTop: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 40, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        donebutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        donebutton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        donebutton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    
}

