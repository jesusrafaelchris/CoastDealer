//
//  bookingView.swift
//  KeyloopDealer
//
//  Created by Christian Grinling on 05/03/2022.
//

import UIKit
import Firebase

class bookingView: UIViewController {
    
    var name: String?
    var service: String?
    var id: String?
    var garageuid: String?
    var stage: String?
    var customeruid: String?
    var numberplate: String?
    var username: String?
    
    lazy var ManageService: UILabel = {
        let text = UILabel()
        if let name = name {
            if let service = service {
                text.layout(colour: .black, size: 25, text: "\(name)'s \(service)", bold: true)
            }
        }
        text.adjustsFontSizeToFitWidth = true
        return text
    }()
    
    lazy var openMessagingButton = imagebutton.setimage(image: "square.and.pencil",size: size,colour: .black)
    
    lazy var CarImage: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFit
        imageview.layer.masksToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "mini.png")
        return imageview
    }()
    
    lazy var dash1 = trackDashView.empty()
    lazy var dash2 = trackDashView.empty()
    lazy var dash3 = trackDashView.empty()
    lazy var dash4 = trackDashView.empty()
    lazy var dash5 = trackDashView.empty()
    
    lazy var dashstackview = equalStackView.layoutTrackDashes(views: [dash1,dash2,dash3,dash4,dash5])
    
    lazy var startTime: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 20, text: "", bold: true)
        text.backgroundColor = UIColor(hexString: "F6F6F6")
        text.layer.cornerRadius = 10
        text.layer.masksToBounds = true
        text.textAlignment = .center
        return text
    }()
    
    lazy var dash: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 20, text: "-", bold: true)
        text.textAlignment = .center
        return text
    }()
    
    lazy var endTime: UILabel = {
        let text = UILabel()
        text.layout(colour: .white, size: 20, text: "", bold: true)
        text.backgroundColor = UIColor(hexString: "222222")
        text.layer.cornerRadius = 10
        text.layer.masksToBounds = true
        text.textAlignment = .center
        return text
    }()
    
    lazy var checktext: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 18, text: "Stage 1 Checks", bold: true)
        return text
    }()
    
    lazy var checkContainer = ContainerView.layout(colour: UIColor(hexString: "F6F6F6"), cornerradius: 20)
    
    lazy var checktext1 = StageCheckText.text(textlabel: "", size: 14)
    lazy var checktext2 = StageCheckText.text(textlabel: "", size: 14)
    lazy var checktext3 = StageCheckText.text(textlabel: "", size: 14)
    
    lazy var checkstackview = equalStackView.layoutUIlabels(labels: [checktext1,checktext2,checktext3], distribution: .fillEqually)
    
    var size:CGFloat = 15
    
    lazy var checkbutton1 = imagebutton.setimage(image: "checkmark.circle",size: size,colour: .black)
    lazy var flagbutton1 = imagebutton.setimage(image: "flag",size: size,colour: .red)
    
    let buttonstack1 = equalStackView()
    
    lazy var checkbutton2 = imagebutton.setimage(image: "checkmark.circle",size: size,colour: .black)
    lazy var flagbutton2 = imagebutton.setimage(image: "flag",size: size,colour: .red)
    
    let buttonstack2 = equalStackView()
    
    lazy var checkbutton3 = imagebutton.setimage(image: "checkmark.circle",size: size,colour: .black)
    lazy var flagbutton3 = imagebutton.setimage(image: "flag",size: size,colour: .red)
    
    let buttonstack3 = equalStackView()
    
    lazy var completetaskbutton = darkblackbutton.textstring(text: "Stage X Complete ->")
    
    var completed = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        getTrackingData()
        setupTargets()
        checkifdone()
        if completed {
            check1test = true
            check2test = true
            check3test = true
        }
    }
    
    func setupTargets() {
        completetaskbutton.addTarget(self, action: #selector(completestage), for: .touchUpInside)
        checkbutton1.addTarget(self, action: #selector(check1), for: .touchUpInside)
        checkbutton2.addTarget(self, action: #selector(check2), for: .touchUpInside)
        checkbutton3.addTarget(self, action: #selector(check3), for: .touchUpInside)
        flagbutton1.addTarget(self, action: #selector(flag1), for: .touchUpInside)
        flagbutton2.addTarget(self, action: #selector(flag2), for: .touchUpInside)
        flagbutton3.addTarget(self, action: #selector(flag3), for: .touchUpInside)
        openMessagingButton.addTarget(self, action: #selector(openmessage), for: .touchUpInside)
    }
    
    @objc func openmessage() {
        let messagelog = MessageLog(collectionViewLayout: UICollectionViewFlowLayout())
        messagelog.userid = self.customeruid
        messagelog.numberplate = self.numberplate
        messagelog.username = self.username
        let navView = UINavigationController(rootViewController: messagelog)
        navigationController?.present(navView, animated: true, completion: nil)
    }
    

    @objc func flag1() {
        let warning = warningCheckView()
        flagbutton1.setsizedImage(symbol: "flag.fill", size: 15, colour: .red)
        warning.modalPresentationStyle = .pageSheet
        warning.bookingID = self.id
        warning.customeruid = self.customeruid
        if let stage = stage {
            warning.stage = stage
        }

        if let sheet = warning.sheetPresentationController {

            sheet.detents = [ .medium()]

        }
        present(warning, animated: true, completion: nil)
    }
    
    @objc func flag2() {
        let warning = warningCheckView()
        flagbutton2.setsizedImage(symbol: "flag.fill", size: 15, colour: .red)
        warning.modalPresentationStyle = .pageSheet
        warning.bookingID = self.id
        warning.customeruid = self.customeruid
        if let stage = stage {
            warning.stage = stage
        }
        if let sheet = warning.sheetPresentationController {

            sheet.detents = [ .medium()]

        }
        present(warning, animated: true, completion: nil)
    }
    
    @objc func flag3() {
        let warning = warningCheckView()
        flagbutton3.setsizedImage(symbol: "flag.fill", size: 15, colour: .red)
        warning.modalPresentationStyle = .pageSheet
        warning.bookingID = self.id
        warning.customeruid = self.customeruid
        if let sheet = warning.sheetPresentationController {

            sheet.detents = [ .medium()]

        }
        present(warning, animated: true, completion: nil)
    }
    
    var check1test = false
    var check2test = false
    var check3test = false
    
    @objc func check1() {
        checkbutton1.setsizedImage(symbol: "checkmark.circle.fill", size: 15, colour: .black)
        self.check1test = true
    }
    
    @objc func check2() {
        checkbutton2.setsizedImage(symbol: "checkmark.circle.fill", size: 15, colour: .black)
        self.check2test = true
    }
    
    @objc func check3() {
        checkbutton3.setsizedImage(symbol: "checkmark.circle.fill", size: 15, colour: .black)
        self.check3test = true
    }
    
    @objc func completestage() {
        
        if (check1test == false || check2test == false || check3test == false) && completed == false {
            self.AlertofError("Error", "Please check all fields")
            return
        }
        
        else {
            check1test = false
            check2test = false
            check3test = false
            checkbutton1.setsizedImage(symbol: "checkmark.circle", size: 15, colour: .black)
            checkbutton2.setsizedImage(symbol: "checkmark.circle", size: 15, colour: .black)
            checkbutton3.setsizedImage(symbol: "checkmark.circle", size: 15, colour: .black)
            
            flagbutton1.setsizedImage(symbol: "flag", size: 15, colour: .red)
            flagbutton2.setsizedImage(symbol: "flag", size: 15, colour: .red)
            flagbutton3.setsizedImage(symbol: "flag", size: 15, colour: .red)
            
            guard let id = self.id else {return}
            let time = "Time"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let date = Date()
            let timeString = dateFormatter.string(from: date)
      
            let trackingref = Firestore.firestore().collection("userbookings").document(id)
            if let stage = stage {
                let stagetime = stage + time
                guard let customeruid = customeruid else {return}

                let userbookingref = Firestore.firestore().collection("users").document(customeruid).collection("Bookings").document(id)
                
                trackingref.setData([stage:true, stagetime:timeString],merge: true)
                userbookingref.setData([stage:true, stagetime:timeString],merge: true)
                
                    if stage == "completed" {
                        check1test = true
                        check2test = true
                        check3test = true
                        self.completed = true
                        //self.navigationController?.popToRootViewController(animated: true)
                        self.checktext.text = "Service Complete"
                        self.completetaskbutton.setTitle("Message Customer", for: .normal)
                        self.completetaskbutton.addTarget(self, action: #selector(self.openmessage), for: .touchUpInside)
                        self.startTime.backgroundColor = UIColor(hexString: "222222")
                        self.startTime.textColor = .white
                        self.checkbutton1.isHidden = true
                        self.checkbutton2.isHidden = true
                        self.checkbutton3.isHidden = true
                        
                        self.flagbutton1.isHidden = true
                        self.flagbutton2.isHidden = true
                        self.flagbutton3.isHidden = true
                        
                        self.checktext1.text = "Service completed at \(timeString)"
                        self.checktext2.text = ""
                        self.endTime.text = timeString
                    }
                }
            }
        }
    
    func checkifdone() {
        guard let id = self.id else {return}
        let trackingref = Firestore.firestore().collection("userbookings").document(id)
            trackingref.getDocument { snapshot, error in
                let data = snapshot?.data()
                guard let completed = data?["completed"] as? Bool else {return}
                guard let completedTime = data?["completedTime"] as? String else {return}
                if completed {
                    self.completed = true
                    //self.navigationController?.popToRootViewController(animated: true)
                    self.checktext.text = "Service Complete"
                    self.completetaskbutton.setTitle("Message Customer", for: .normal)
                    self.completetaskbutton.addTarget(self, action: #selector(self.openmessage), for: .touchUpInside)
                    self.startTime.backgroundColor = UIColor(hexString: "222222")
                    self.startTime.textColor = .white
                    self.checkbutton1.isHidden = true
                    self.checkbutton2.isHidden = true
                    self.checkbutton3.isHidden = true
                    
                    self.flagbutton1.isHidden = true
                    self.flagbutton2.isHidden = true
                    self.flagbutton3.isHidden = true
                    
                    self.checktext1.text = "Service completed at \(completedTime)"
                    self.endTime.text = completedTime
            }
        }
    }
    
    func setupView() {
        view.addSubview(ManageService)
        view.addSubview(openMessagingButton)
        view.addSubview(dashstackview)
        view.addSubview(CarImage)
        view.addSubview(startTime)
        view.addSubview(dash)
        view.addSubview(endTime)
        view.addSubview(checktext)
        view.addSubview(checkContainer)
        view.addSubview(checkstackview)
        view.addSubview(buttonstack1)
        view.addSubview(buttonstack2)
        view.addSubview(buttonstack3)
        
        
        buttonstack1.addArrangedSubview(checkbutton1)
        buttonstack1.addArrangedSubview(flagbutton1)
        
        buttonstack2.addArrangedSubview(checkbutton2)
        buttonstack2.addArrangedSubview(flagbutton2)
        
        buttonstack3.addArrangedSubview(checkbutton3)
        buttonstack3.addArrangedSubview(flagbutton3)
        
        
        view.addSubview(completetaskbutton)
        
        ManageService.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 15, right: nil, paddingRight: 0, width: 0, height: 0)
        
        openMessagingButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 15, right: view.rightAnchor, paddingRight: 15, width: 0, height: 0)
        
        dashstackview.anchor(top: ManageService.bottomAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 40, right: view.rightAnchor, paddingRight: 40, width: 0, height: 0)
        
        CarImage.anchor(top: dashstackview.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 40, right:view.rightAnchor, paddingRight: 40, width: 0, height: 0)
        CarImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        CarImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        startTime.anchor(top: CarImage.bottomAnchor, paddingTop: -40, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: dash.leftAnchor, paddingRight: 2.5, width: 100, height: 50)
        
        dash.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 2.5, right: nil, paddingRight: 5, width: 20, height: 20)
        dash.centerYAnchor.constraint(equalTo: startTime.centerYAnchor).isActive = true
        dash.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        endTime.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: dash.rightAnchor, paddingLeft: 2.5, right: nil, paddingRight: 5, width: 100, height: 50)
        endTime.centerYAnchor.constraint(equalTo: startTime.centerYAnchor).isActive = true
        
        checktext.anchor(top: startTime.bottomAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 15, right: nil, paddingRight: 0, width: 0, height: 0)
        
        checkContainer.anchor(top: checktext.bottomAnchor, paddingTop: 20, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 0, right: nil, paddingRight: 5, width: 0, height: 0)
        checkContainer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        checkContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        checkContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        checkstackview.anchor(top: checkContainer.topAnchor, paddingTop: 0, bottom: checkContainer.bottomAnchor, paddingBottom: 0, left: checkContainer.leftAnchor, paddingLeft: 15, right: buttonstack1.rightAnchor, paddingRight: 30, width: 0, height: 0)
        
        buttonstack1.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: checkstackview.rightAnchor, paddingLeft: 15, right: checkContainer.rightAnchor, paddingRight: 15, width: 0, height: 0)
        buttonstack1.centerYAnchor.constraint(equalTo: checkstackview.subviews[0].centerYAnchor).isActive = true
        buttonstack1.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        
        buttonstack2.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 15, right: checkContainer.rightAnchor, paddingRight: 15, width: 0, height: 0)
        buttonstack2.centerYAnchor.constraint(equalTo: checkstackview.subviews[1].centerYAnchor).isActive = true
        buttonstack2.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        
        buttonstack3.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 15, right: checkContainer.rightAnchor, paddingRight: 15, width: 0, height: 0)
        buttonstack3.centerYAnchor.constraint(equalTo: checkstackview.subviews[2].centerYAnchor).isActive = true
        buttonstack3.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        
        
        completetaskbutton.anchor(top: nil, paddingTop: 0, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 20, left: nil, paddingLeft: 0, right: nil, paddingRight: 0, width: 0, height: 0)
        completetaskbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        completetaskbutton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        completetaskbutton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
    }

}

//MARK: NETWORK FIREBASE CALL

extension bookingView {
    
    func getTrackingData() {
        guard let id = self.id else {return}
        let trackingref = Firestore.firestore().collection("userbookings").document(id)

        trackingref.addSnapshotListener({ snapshot, error in

            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = snapshot?.data() else {return}
            
            let booking = bookingdocumentclass(dictionary: data)
            
            self.customeruid = booking.customeruid
            
            guard let checkincompleted = booking.checkedIn else {return}
            guard let checkintime = booking.checkInTime else {return}
            self.startTime.text = checkintime
            guard let endtimeasdate = checkintime.toDateFormat(format: "HH:mm") else {return}
            
            guard let endtime = Calendar.current.date(byAdding: .minute, value: 45, to: endtimeasdate) else {return}
            
            self.endTime.text = endtime.getFormattedDate(format: "HH:mm")
            
            trackingref.setData(["endTime":endtime.getFormattedDate(format: "HH:mm")],merge: true)
            
            guard let customeruid = booking.customeruid else {return}
            
            let userbookingref = Firestore.firestore().collection("users").document(customeruid).collection("Bookings").document(id)
            
            userbookingref.setData(["endTime":endtime.getFormattedDate(format: "HH:mm")],merge: true)

            guard let recievedcompleted = booking.recieved else {return}

            guard let stage1completed = booking.stage1 else {return}
    
            guard let stage2completed = booking.stage2 else {return}

            guard let completedbool = booking.completed else {return}
            
            self.garageuid = booking.id
            self.numberplate = booking.car
            self.username = booking.name
            
            if checkincompleted {
                self.dash1.backgroundColor = .black
            }
            
            if recievedcompleted {
                self.dash2.backgroundColor = .black
            }

            if stage1completed {
                self.dash3.backgroundColor = .black
            }
            else {
                self.checktext1.text = "Tyre Inspection"
                self.checktext2.text = "Under bonnet inspection"
                self.checktext3.text = "Headlamp alignment"
                self.checktext.text = "Stage 1 Checks"
                self.completetaskbutton.setTitle("Complete Stage 1", for: .normal)
                self.stage = "stage1"
            }
            
            if stage2completed {
                self.dash4.backgroundColor = .black
            }
            
            else if stage1completed == true && stage2completed == false {
                self.checktext1.text = "Brake test"
                self.checktext2.text = "Interior inspection"
                self.checktext3.text = "Under body inspection"
                self.checktext.text = "Stage 2 Checks"
                self.completetaskbutton.setTitle("Complete Stage 2", for: .normal)
                self.stage = "stage2"
                
            }
            
            if completedbool {
                self.dash5.backgroundColor = .black
            }
            
            else if stage1completed == true && stage2completed == true {
                self.check1test = true
                self.check2test = true
                self.check3test = true
                self.checkbutton1.isHidden = true
                self.checkbutton2.isHidden = true
                self.checkbutton3.isHidden = true
                
                //self.flagbutton1.isHidden = true
                self.flagbutton1.setsizedImage(symbol: "flag.fill", size: 15, colour: .red)
                self.flagbutton2.setsizedImage(symbol: "flag.fill", size: 15, colour: .red)
                //self.flagbutton2.isHidden = true
                self.flagbutton1.isHidden = true
                self.flagbutton2.isHidden = true
                self.flagbutton3.isHidden = true
                
                
                //get advisory notice items and display them in the grid for the final thing
                //then send message saying to get them done
                let advisory1 = data["stage1advisory"] as? String ?? ""
                let advisory2 = data["stage2advisory"] as? String ?? ""
                
                self.checktext1.text = advisory1
                self.checktext2.text = advisory2
                
                self.checktext3.text = ""
                self.stage = "completed"
                self.checktext.text = "Advisory Notices"
                self.completetaskbutton.setTitle("Complete Service", for: .normal)
            }
        })
    }
}
