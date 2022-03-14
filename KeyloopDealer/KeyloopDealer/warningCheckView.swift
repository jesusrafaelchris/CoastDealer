//
//  warningCheckView.swift
//  KeyloopDealer
//
//  Created by Christian Grinling on 06/03/2022.
//

import UIKit
import Firebase

class warningCheckView: UIViewController {

    var underbonnetfaults = ["Registration plates and vehicle identification number (VIN)","Power assisted steering","Engine transmission mounts","Mechanical brake components","Hydraulic, air and vacuum brake systems", "Fuel system", "Brake and steering fluids", "General condition of the vehicle", "Vehicle structural integrity and construction"]
    
    lazy var advisorystepper = UIStepper()
    lazy var minorstepper = UIStepper()
    lazy var majorstepper = UIStepper()
    lazy var dangerousstepper = UIStepper()
    
    var bookingID: String?
    var customeruid: String?
    var stage: String?
    
    lazy var AddFault: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 25, text: "Add Fault", bold: true)
        text.adjustsFontSizeToFitWidth = true
        return text
    }()
    
    lazy var AdvisoryNotice = faultText.text(textlabel: "Advisory Notice", size: 16)
    lazy var Minor = faultText.text(textlabel: "Minor", size: 16)
    lazy var Major = faultText.text(textlabel: "Major", size: 16)
    lazy var Dangerous = faultText.text(textlabel: "Dangerous", size: 16)
    
    lazy var equalstack = equalStackView.layoutUIlabels(labels: [AdvisoryNotice,Minor,Major,Dangerous], distribution: .fillEqually)
    
    lazy var addfaultsbutton = darkblackbutton.textstring(text: "Submit Warnings")
    
    lazy var textfield: UITextField = {
        let textfield = UITextField()
        textfield.layout(placeholder: "   Add warning", backgroundcolour: UIColor(hexString: "F6F6F6"), bordercolour: .clear, borderWidth: 0, cornerRadius: 10)
        return textfield
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        advisorystepper.autorepeat = false
        advisorystepper.addTarget(self, action: #selector(advisorystepperChanged(_:)), for: .valueChanged)
        addfaultsbutton.addTarget(self, action: #selector(addfaults), for: .touchUpInside)
        setupView()
        view.backgroundColor = .white
        
    }
    
    @objc func addfaults() {
        guard let fault = textfield.text else {return}
        guard let id = bookingID else {return}
        guard let customeruid = customeruid else {return}

        let ref = Firestore.firestore().collection("userbookings").document(id)
        let userbookingref = Firestore.firestore().collection("users").document(customeruid).collection("Bookings").document(id)
        
        sendMessage(text: "Dick Lovett Mini has given an Advisory notice for your car FP63YVF - ⚠️\(fault)⚠️")
        sendMessage(text: "Dick Lovett Mini has advised to replace these items - please confirm your booking🔧")
        if let stage = stage {
            let stageError = stage + "error"
            ref.setData([stageError:true],merge: true)
            userbookingref.setData([stageError:true],merge: true)
            
            let advisory = stage + "advisory"
            userbookingref.setData([advisory:fault],merge: true)
            ref.setData([advisory:fault],merge: true) { error in
                self.dismiss(animated: true, completion: nil)
            }
        }

    }
    
    @objc func advisorystepperChanged(_ sender:UIStepper) {
        print("UIStepper is now \(Int(sender.value))")
        equalstack.insertArrangedSubview(textfield, at: 1)
        textfield.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.8).isActive = true
        textfield.heightAnchor.constraint(equalTo: view.widthAnchor,multiplier: 0.12).isActive = true
    }
    
    func setupView() {
        view.addSubview(AddFault)
        view.addSubview(equalstack)
        view.addSubview(addfaultsbutton)
        view.addSubview(advisorystepper)
        view.addSubview(minorstepper)
        view.addSubview(majorstepper)
        view.addSubview(dangerousstepper)
        
        AddFault.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width: 0, height: 0)
        
        equalstack.anchor(top: AddFault.bottomAnchor, paddingTop: 10, bottom: addfaultsbutton.topAnchor, paddingBottom: 10, left: view.leftAnchor, paddingLeft: 30, right: nil, paddingRight: 0, width: 0, height: 0)
        
        let stepperwidth: CGFloat = 0.05
        let stepperheight: CGFloat = 30
        
        advisorystepper.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 15, right: view.rightAnchor, paddingRight: 15, width: 0, height: stepperheight)
        advisorystepper.centerYAnchor.constraint(equalTo: equalstack.subviews[0].centerYAnchor).isActive = true
        //advisorystepper.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: stepperwidth).isActive = true
        
        minorstepper.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 15, right: view.rightAnchor, paddingRight: 15, width: 0, height: stepperheight)
        minorstepper.centerYAnchor.constraint(equalTo: equalstack.subviews[1].centerYAnchor).isActive = true
       // minorstepper.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: stepperwidth).isActive = true
        
        majorstepper.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 15, right: view.rightAnchor, paddingRight: 15, width: 0, height: stepperheight)
        majorstepper.centerYAnchor.constraint(equalTo: equalstack.subviews[2].centerYAnchor).isActive = true
        //majorstepper.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: stepperwidth).isActive = true
        
        dangerousstepper.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 15, right: view.rightAnchor, paddingRight: 15, width: 0, height: stepperheight)
        dangerousstepper.centerYAnchor.constraint(equalTo: equalstack.subviews[3].centerYAnchor).isActive = true
        //dangerousstepper.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: stepperwidth).isActive = true
        
        addfaultsbutton.anchor(top: nil, paddingTop: 20, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 30, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        addfaultsbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addfaultsbutton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        addfaultsbutton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        
    }
    
    func sendMessage(text: String) {
        
        let fromID = "6qjvaNBtSeJySgQbgCOI"
        let timestamp = NSDate.timeIntervalSinceReferenceDate
        guard let toID = self.customeruid else {return}
        
        let data: [String : Any] =
            ["Text": text,
            "TimeStamp": timestamp,
            "FromID": fromID,
            "ToID": toID]

            
        let ref = Firestore.firestore().collection("user-messages").document(fromID).collection(toID)
            ref.addDocument(data: data)
                
        let recipientUserMessagesRef = Firestore.firestore().collection("user-messages").document(toID).collection(fromID)
            recipientUserMessagesRef.addDocument(data: data)
            
        let latestmessageRef1 = Firestore.firestore().collection("Latest-Messages").document(fromID).collection("Latest").document(toID)
            latestmessageRef1.setData(data)
        
        let latestmessageRef2 = Firestore.firestore().collection("Latest-Messages").document(toID).collection("Latest").document(fromID)
            latestmessageRef2.setData(data)

        }

}
