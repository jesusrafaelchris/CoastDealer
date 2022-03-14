//
//  Homepage.swift
//  KeyloopDealer
//
//  Created by Christian Grinling on 04/03/2022.
//

import UIKit
import Firebase

class Homepage: UIViewController {

    var bookings = [bookingdocumentclass]()
    let sizes = [75,100,75,50,100,30,100]
    var dates = [daystruct]()
    //let days = ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]
    
    lazy var CoastTitle: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 28, text: "CoastDealer", bold: true)
        return text
    }()
    
    lazy var LogoImage: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.layer.masksToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "Logo_Black")
        return imageview
    }()
    
    lazy var garageName: UILabel = {
        let text = UILabel()
        text.layout(colour: UIColor(hexString: "5D6F85"), size: 12, text: "Dick Lovett Mini Bristol", bold: false)
        return text
    }()
    
    lazy var garageImage: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.layer.masksToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "dicklovett")
        imageview.layer.cornerRadius = 25
        imageview.layer.masksToBounds = true
        return imageview
    }()
    
    lazy var dateLabel: UILabel = {
        let text = UILabel()
        let date = getDate()
        text.layout(colour: .black, size: 12, text: "\(date)", bold: false)
        return text
    }()
    
    lazy var salesToday: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 12, text: "Sales Today", bold: false)
        return text
    }()
    
    lazy var salesText: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 40, text: "£560", bold: false)
        text.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        return text
    }()
    
    lazy var percentText: UILabel = {
        let text = UILabel()
        text.layout(colour: .black, size: 16, text: "▼  1.87%", bold: false)
        //text.font = UIFont.systemFont(ofSize: 40, weight: .heavy)
        text.textColor = UIColor(hexString: "FF0000")
        text.backgroundColor = UIColor(hexString: "FFA9A9")
        text.textAlignment = .center
        text.layer.cornerRadius = 10
        text.layer.masksToBounds = true
        text.adjustsFontSizeToFitWidth = true
        return text
    }()
    
    lazy var weekCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionview = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionview.register(WeekCell.self, forCellWithReuseIdentifier: "cell")
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.backgroundColor = .white
        //collectionview.isScrollEnabled = false
        return collectionview
    }()
    
    lazy var BookingsText: UIButton = {
        let button = UIButton()
        button.layout(textcolour: .black, backgroundColour: .clear, size: 16, text: "Bookings", image: nil, cornerRadius: nil)
        return button
    }()
    
    lazy var mealView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 0.31, green: 0.50, blue: 0.99, alpha: 1.00)
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var BookingsCollectionView: SelfSizedCollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = SelfSizedCollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionview.register(BookingCell.self, forCellWithReuseIdentifier: "bookingCell")
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.backgroundColor = .clear
        collectionview.layer.cornerRadius = 0
        collectionview.layer.masksToBounds = true
        collectionview.isScrollEnabled = true
        return collectionview
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let ref = Firestore.firestore().collection("userbookings").document("TmwFMsbq8TzQ13E9uyWi")
//        ref.setData(["created":Timestamp(date: Date())],merge: true)
        view.backgroundColor = .white
        setupView()
        setupweeks()
        //print(getDayOfWeek())
        let date = self.getTodaysDateforbooking()
        getbookingsforgarage(date: date)
    }
    
    func setupweeks() {
        let money = ["£560", "£748", "£654","£221","£1029","£187","£892"]
        let percent = [0.12, 1.39, 1.87,0.33,4.56,0.18,4.77]
        
        let weekdates = Date().getWeekDates()
        for (index, element) in weekdates.thisWeek.enumerated() {
        let weekday = getDateasDay(date: element)
        let day = daystruct(day: weekday, date: element,money: money[index], percent: percent[index])
            dates.append(day)
            DispatchQueue.main.async {
                self.weekCollectionView.reloadData()
            }
        }
    }

    
    func setupView() {
        view.addSubview(CoastTitle)
        view.addSubview(LogoImage)
        view.addSubview(garageName)
        view.addSubview(garageImage)
        view.addSubview(dateLabel)
        view.addSubview(salesToday)
        view.addSubview(salesText)
        view.addSubview(percentText)
        
        view.addSubview(weekCollectionView)
        view.addSubview(BookingsText)
        view.addSubview(BookingsCollectionView)
        
        CoastTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 30, right: nil, paddingRight: 0, width: 0, height: 0)
        
        LogoImage.anchor(top: nil, paddingTop: 10, bottom: nil, paddingBottom: 0, left: CoastTitle.rightAnchor, paddingLeft: 8, right: nil, paddingRight: 0, width: 25, height: 25)
        LogoImage.centerYAnchor.constraint(equalTo: CoastTitle.centerYAnchor).isActive = true
        
        garageName.anchor(top: CoastTitle.bottomAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 30, right: nil, paddingRight: 0, width: 0, height: 0)
        
        salesToday.anchor(top: garageName.bottomAnchor, paddingTop: 30, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 30, right: nil, paddingRight: 0, width: 0, height: 0)
        
        salesText.anchor(top: salesToday.bottomAnchor, paddingTop: 5, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 30, right: nil, paddingRight: 0, width: 0, height: 0)
        
        percentText.anchor(top: nil, paddingTop: 5, bottom: nil, paddingBottom: 0, left: salesText.rightAnchor, paddingLeft: 20, right: nil, paddingRight: 0, width:80, height: 30)
        percentText.centerYAnchor.constraint(equalTo: salesText.centerYAnchor).isActive = true
        
        garageImage.anchor(top: nil, paddingTop: 0, bottom: nil, paddingBottom: 0, left: nil, paddingLeft: 30, right: view.rightAnchor, paddingRight: 30, width: 50, height: 50)
        garageImage.centerYAnchor.constraint(equalTo: salesText.centerYAnchor).isActive = true
        
        dateLabel.anchor(top: salesText.bottomAnchor, paddingTop: 10, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 35, right: nil, paddingRight: 0, width: 0, height: 0)
        
        weekCollectionView.anchor(top: dateLabel.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 20, right: view.rightAnchor, paddingRight: 20, width: 0, height: 0)
        weekCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        
        BookingsText.anchor(top: weekCollectionView.bottomAnchor, paddingTop: 0, bottom: nil, paddingBottom: 0, left: view.leftAnchor, paddingLeft: 30, right: nil, paddingRight: 0, width: 0, height: 0)
        
        BookingsCollectionView.anchor(top: BookingsText.bottomAnchor, paddingTop: 5, bottom: nil, paddingBottom: 10, left: view.leftAnchor, paddingLeft: 30, right: view.rightAnchor, paddingRight: 30, width: 0, height: 0)

    }
    
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10, bottom: 10.0, right: 10)
    let numberOfItemsPerRow: CGFloat = 7
    let spacingBetweenCells: CGFloat = 5
    let bookingsectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    func getbookingsforgarage(date:String) {
        print("getting bookings")
        let ref = Firestore.firestore().collection("userbookings").whereField("garage", isEqualTo: "Dick Lovett Mini Bristol").whereField("date", isEqualTo: date).order(by: "startTime",descending: false)
        ref.addSnapshotListener { snapshot, error in
            if snapshot?.documents.count == 0 {
                print("no documents")
                self.bookings.removeAll()
                DispatchQueue.main.async {
                    self.BookingsCollectionView.reloadData()
                }
            }
            guard let documents = snapshot?.documents else {return}
            self.bookings.removeAll()
            for document in documents {
                let data = document.data()
                let booking = bookingdocumentclass(dictionary: data)
                self.bookings.append(booking)
                DispatchQueue.main.async {
                    self.BookingsCollectionView.reloadData()
                }
            }
        }
    }
}


extension Homepage:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func selectitematindexpath(indexpath: IndexPath) {
        weekCollectionView.selectItem(at: indexpath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.weekCollectionView {
            return 7
        }
        return bookings.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.weekCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeekCell
            let date = dates[indexPath.item]
            
            UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: UIView.AnimationOptions.curveEaseInOut,
                animations: ({
                cell.heightConstraint?.constant = CGFloat(self.sizes[indexPath.item])
                cell.dayView.layoutIfNeeded()
            }), completion: nil)

            
            if  date.day == getTodaysDateasDay() {
                selectitematindexpath(indexpath:indexPath)
            }
            else {
                cell.isSelected = false
            }
            cell.dayLabel.text = date.day
            cell.backgroundColor = .white
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bookingCell", for: indexPath) as! BookingCell
            let booking = bookings[indexPath.item]
            cell.backgroundColor = .white
            cell.ServiceName.text = booking.service
            if let service = booking.service {
                cell.ServiceImage.image = UIImage(named: service)?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
            }
            cell.startTime.text = booking.startTime
            cell.CustomerName.text = booking.name
            cell.endTime.text = booking.endTime
            cell.NumberPlateText.text = booking.car
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.weekCollectionView {
            let totalSpacing = (2 * sectionInsets.left) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
            let width = (weekCollectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
            let height = weekCollectionView.bounds.height / 1.5
                return CGSize(width: width, height: height)
        }
        
        else {
            let itemWidth = collectionView.bounds.width
            let itemheight = view.bounds.height / 11
            let itemSize = CGSize(width: itemWidth, height: itemheight)
            return itemSize
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.weekCollectionView {
            return 5
        }
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.weekCollectionView {
         return spacingBetweenCells
        }
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == self.weekCollectionView {
            return sectionInsets
        }
        return bookingsectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.weekCollectionView {
            let day = dates[indexPath.item]
            //set money and percentage for that day text
            self.salesText.text = day.money
            
            if day.percent < 1 {
                self.percentText.textColor = UIColor(hexString: "FF0000")
                self.percentText.text = "▼ \(day.percent)%"
                self.percentText.backgroundColor = UIColor(hexString: "FFA9A9")
            }
            else if day.percent > 1 {
                self.percentText.textColor = UIColor(hexString: "0F9814")
                self.percentText.backgroundColor = UIColor(hexString: "ADEAB0")
                self.percentText.text = "▲ \(day.percent)%"
            }
            
            // get bookings for that day
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMM yyyy"
            let datestring = dateFormatter.string(from: day.date)
            getbookingsforgarage(date: datestring)
        }
        else {
            let booking = bookings[indexPath.item]
            
            if booking.checkedIn == false {
                let checkin = checkinwait()
                checkin.name = booking.name
                navigationController?.present(checkin, animated: true, completion: nil)
            }
            
            else if booking.checkedIn == true && booking.recieved == false {
                let recieved = RecieveCar()
                recieved.numberplate = booking.car
                recieved.name = booking.name
                recieved.id = booking.id
                navigationController?.present(recieved, animated: true, completion: nil)
            }
            
            else if booking.checkedIn == true && booking.recieved == true {
                let bookingview = bookingView()
                bookingview.name = booking.name
                bookingview.service = booking.service
                bookingview.id = booking.id
                navigationController?.pushViewController(bookingview, animated: true)
            }
        }
    }
    
    
}


struct daystruct {
    var day:String
    var date:Date
    var money: String
    var percent: Double
}
