//
//  checkinwait.swift
//  KeyloopDealer
//
//  Created by Christian Grinling on 05/03/2022.
//

import UIKit

class checkinwait: UIViewController {
    
    var name:String?
    
    lazy var carImage: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.layer.masksToBounds = true
        imageview.layer.cornerRadius = 10
        imageview.layer.masksToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "checkin1")
        return imageview
    }()
    
    lazy var checkinwaittext: UILabel = {
        let text = UILabel()
        if let name = name {
            text.layout(colour: .black, size: 20, text: "Waiting for \(name)\n to check in", bold: true)
        }
        text.numberOfLines = 0
        text.textAlignment = .center
        return text
    }()
    
    let donebutton = darkblackbutton.textstring(text: "Done")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        donebutton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }

    func setupView() {
        view.addSubview(carImage)
        view.addSubview(checkinwaittext)
        view.addSubview(donebutton)
        
        carImage.anchor(top: nil, paddingTop: 0, bottom: view.centerYAnchor, paddingBottom: 0, left: nil, paddingLeft: 20, right: nil, paddingRight: 20, width: 0, height: 0)
        carImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        carImage.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true
        carImage.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        
        checkinwaittext.anchor(top: carImage.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 40, right: nil, paddingRight: 40, width: 0, height: 0)
        checkinwaittext.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        checkinwaittext.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        
        donebutton.anchor(top: nil, paddingTop: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 40, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        donebutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        donebutton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        donebutton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }
    
}

