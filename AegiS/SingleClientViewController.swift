//
//  SingleClientViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 4/12/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class SingleClientViewController: UIViewController, UIScrollViewDelegate {

    var backgroundImage = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var topBackgroundView = UIView()
    var backButton = UIButton()
    var editButton = UIButton()
    var titleLabel = UILabel()
    
    var mainScrollView = UIScrollView()
    var mainView = UIView()
    var nameLabel = UITextField()
    var emailLabel = UITextField()
    var emailIcon = UIImageView(image: UIImage(systemName: "person.fill"))
    var phoneLabel = UITextField()
    var phoneIcon = UIImageView(image: UIImage(systemName: "phone.fill"))
    var image = UIImageView()
    var line1 = UIView()
    var languageTitle = UILabel()
    var languageLabel = UITextField()
    var currencyTitle = UILabel()
    var currencyLabel = UITextField()
    var sectorTitle = UILabel()
    var sectorLabel = UITextField()
    var statusTitle = UILabel()
    var statusLabel = UITextField()
    var addressTitle = UILabel()
    var addressLabel = UITextField()
    var viewOnMapButton = UIButton()
    var mapView = UIView()
    var map = MKMapView()
    var location = CLLocationCoordinate2D()
    
    var summaryTitle = UILabel()
    var summaryView1 = UIView()
    var summaryView2 = UIView()
    var summaryView3 = UIView()
    var portfoliosTitle = UILabel()
    var portfoliosScrollView = UIScrollView()
    var portfolioViews = [UIView]()
    var dotsLabel = UIPageControl()
    
    var clientEditing = false
    var client = [String: AnyObject]()
    var changedItems = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.overrideUserInterfaceStyle = .light
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        
        backgroundImage.frame.size.width = self.view.frame.size.width
        backgroundImage.frame.size.height = self.view.frame.size.height
        backgroundImage.contentMode = .scaleAspectFill
        
        topBackgroundView.frame.size.width = self.view.frame.size.width
        topBackgroundView.frame.size.height = self.view.frame.size.height*2.5/7
        topBackgroundView.clipsToBounds = true
        topBackgroundView.layer.cornerRadius = 40
        topBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        backButton.frame.size.width = self.view.frame.width/10
        backButton.frame.size.height = backButton.frame.width
        backButton.frame.origin.y = 50
        backButton.frame.origin.x = 10
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        backButton.tintColor = .white
        
        editButton.frame.size.width = self.view.frame.width/8
        editButton.frame.size.height = backButton.frame.width
        editButton.frame.origin.y = 40
        editButton.frame.origin.x = self.view.frame.width - backButton.frame.width - 20
        if clientEditing {
            editButton.setTitle("DONE", for: .normal)
            backButton.isEnabled = false
        }
        else {
            editButton.setTitle("EDIT", for: .normal)
            backButton.isEnabled = true
        }
        editButton.addTarget(self, action: #selector(edit), for: .touchUpInside)
        editButton.tintColor = .white
        
        titleLabel.text = "CLIENT"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.sizeToFit()
        titleLabel.center.x = self.view.center.x
        titleLabel.frame.origin.y = 40
        
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium)
        let homeImage = UIImage(systemName: "arrow.uturn.left", withConfiguration: homeSymbolConfiguration)
        backButton.setImage(homeImage, for: .normal)
        
        mainScrollView.frame.size.width = self.view.frame.width
        mainScrollView.frame.size.height = self.view.frame.height - 40
        mainScrollView.frame.origin.y = titleLabel.frame.origin.y + titleLabel.frame.height + 10
        mainScrollView.backgroundColor = .clear
        mainScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height*1.1)
        
        mainView.frame.size.width = self.view.frame.width - 50 - 20
        mainView.frame.size.height = self.view.frame.height*3/7
        mainView.frame.origin.x = 35
        mainView.frame.origin.y = mainView.frame.width/4/2
        mainView.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 7.5), opacity: 0.8, shadowRadius: 5, cornerRadius: 10.0, corners: [.allCorners], fillColor: .white)
        
        mapView.frame.size.width = mainView.frame.size.width
        mapView.frame.size.height = mapView.frame.width
        mapView.frame.origin.x = 35
        mapView.frame.origin.y = mainView.frame.origin.y + mainView.frame.height/2
        mapView.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 7.5), opacity: 0.8, shadowRadius: 5, cornerRadius: 10.0, corners: [.bottomLeft, .bottomRight], fillColor: .white)
        mapView.alpha = 0
        
        image.frame.size.width = mainView.frame.width/4
        image.frame.size.height = image.frame.width
        image.frame.origin.x = mainView.frame.width - image.frame.width - 25
        image.frame.origin.y = -image.frame.height/2
        image.layer.cornerRadius = image.frame.width/2
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 1
        image.contentMode = .scaleAspectFill
        if clientEditing {
            image.backgroundColor = .lightGray
        }
        else {
            image.image = client["Image"] as? UIImage
        }
        
        nameLabel.frame.size.width = mainView.frame.width*2/3
        nameLabel.frame.size.height = mainView.frame.height/10
        nameLabel.frame.origin.x = 25
        nameLabel.frame.origin.y = 25
        if clientEditing {
            nameLabel.placeholder = "Full Name"
            nameLabel.isEnabled = true
        }
        else {
            nameLabel.text = "\((client["Name"] as! String) + " " + (client["Surname"] as! String))"
            nameLabel.isEnabled = false
        }
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        nameLabel.accessibilityLabel = "Full Name"
        
        emailLabel.frame.size.width = mainView.frame.width*2/3
        emailLabel.frame.size.height = mainView.frame.height/10
        emailLabel.frame.origin.y = nameLabel.frame.origin.y + nameLabel.frame.height
        emailLabel.textColor = .gray
        if clientEditing {
            emailLabel.placeholder = "Email"
            emailLabel.isEnabled = true
        }
        else {
            emailLabel.text = "\(client["Email"] as! String)"
            emailLabel.isEnabled = false
        }
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        emailLabel.accessibilityLabel = "Email"
        
        emailIcon.frame.size.height = emailLabel.frame.height/1.5
        emailIcon.frame.size.width = emailIcon.frame.height
        emailIcon.frame.origin.x = 25
        emailIcon.center.y = emailLabel.center.y
        emailIcon.tintColor = .gray
        
        emailLabel.frame.origin.x = emailIcon.frame.origin.x + emailIcon.frame.width + 5
        
        phoneLabel.frame.size.width = mainView.frame.width*2/3
        phoneLabel.frame.size.height = mainView.frame.height/10
        phoneLabel.frame.origin.y = emailLabel.frame.origin.y + emailLabel.frame.height
        phoneLabel.textColor = .gray
        if clientEditing {
            phoneLabel.placeholder = "Phone"
            phoneLabel.isEnabled = true
        }
        else {
            phoneLabel.text = client["Phone"] as? String
            phoneLabel.isEnabled = false
        }
        phoneLabel.adjustsFontSizeToFitWidth = true
        phoneLabel.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        phoneLabel.accessibilityLabel = "Phone"
        
        phoneIcon.frame.size = emailIcon.frame.size
        phoneIcon.frame.origin.x = 25
        phoneIcon.center.y = phoneLabel.center.y
        phoneIcon.tintColor = .gray
        
        phoneLabel.frame.origin.x = phoneIcon.frame.origin.x + phoneIcon.frame.width + 5
        
        line1.frame.size.width = mainView.frame.width/1.5
        line1.frame.size.height = 2
        line1.frame.origin.y = phoneLabel.frame.origin.y + phoneLabel.frame.height + 10
        line1.center.x = mainView.frame.width/2
        line1.backgroundColor = .gray
        
        languageTitle.frame.size.width = mainView.frame.width*2/3
        languageTitle.frame.size.height = mainView.frame.height/10
        languageTitle.frame.origin.x = 25
        languageTitle.frame.origin.y = line1.frame.origin.y + line1.frame.height + 10
        languageTitle.text = "Language of Reporting"
        
        languageLabel.frame.size.width = mainView.frame.width*2/3
        languageLabel.frame.size.height = mainView.frame.height/10
        languageLabel.frame.origin.x = 25
        languageLabel.frame.origin.y = languageTitle.frame.origin.y + languageTitle.frame.height - 10
        if clientEditing {
            languageLabel.placeholder = "Language"
            languageLabel.isEnabled = true
        }
        else {
            languageLabel.text = client["Language of Reporting"] as? String
            languageLabel.isEnabled = false
        }
        languageLabel.textColor = .gray
        languageLabel.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        languageLabel.accessibilityLabel = "Language of Reporting"
        
        sectorTitle.frame.size.width = mainView.frame.width*1/3
        sectorTitle.frame.size.height = mainView.frame.height/10
        sectorTitle.frame.origin.x = mainView.frame.width - sectorTitle.frame.width - 25
        sectorTitle.frame.origin.y = languageTitle.frame.origin.y
        sectorTitle.text = "Sector"
        sectorTitle.textAlignment = .right
        
        sectorLabel.frame.size.width = mainView.frame.width*1/3
        sectorLabel.frame.size.height = mainView.frame.height/10
        sectorLabel.frame.origin.x = mainView.frame.width - sectorLabel.frame.width - 25
        sectorLabel.frame.origin.y = languageLabel.frame.origin.y
        if clientEditing {
            sectorLabel.placeholder = "Sector"
            sectorLabel.isEnabled = true
        }
        else {
            sectorLabel.text = client["Sector"] as? String
            sectorLabel.isEnabled = false
        }
        sectorLabel.textColor = .gray
        sectorLabel.textAlignment = .right
        sectorLabel.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        sectorLabel.accessibilityLabel = "Sector"
        
        currencyTitle.frame.size.width = mainView.frame.width*2/3
        currencyTitle.frame.size.height = mainView.frame.height/10
        currencyTitle.frame.origin.x = 25
        currencyTitle.frame.origin.y = languageLabel.frame.origin.y + languageLabel.frame.height
        currencyTitle.text = "Reporting Currency"
        
        currencyLabel.frame.size.width = mainView.frame.width*2/3
        currencyLabel.frame.size.height = mainView.frame.height/10
        currencyLabel.frame.origin.x = 25
        currencyLabel.frame.origin.y = currencyTitle.frame.origin.y + currencyTitle.frame.height - 10
        if clientEditing {
            currencyLabel.placeholder = "Currency"
            currencyLabel.isEnabled = true
        }
        else {
            currencyLabel.text = client["Reporting Currency"] as? String
            currencyLabel.isEnabled = false
        }
        currencyLabel.textColor = .gray
        currencyLabel.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        currencyLabel.accessibilityLabel = "Reporting Currency"
        
        statusTitle.frame.size.width = mainView.frame.width*1/3
        statusTitle.frame.size.height = mainView.frame.height/10
        statusTitle.frame.origin.x = mainView.frame.width - statusTitle.frame.width - 25
        statusTitle.frame.origin.y = currencyTitle.frame.origin.y
        statusTitle.text = "Status"
        statusTitle.textAlignment = .right
        
        statusLabel.frame.size.width = mainView.frame.width*1/3
        statusLabel.frame.size.height = mainView.frame.height/10
        statusLabel.frame.origin.x = mainView.frame.width - statusLabel.frame.width - 25
        statusLabel.frame.origin.y = currencyLabel.frame.origin.y
        if clientEditing {
            statusLabel.placeholder = "Status"
            statusLabel.isEnabled = true
        }
        else {
            statusLabel.text = client["Customer Status"] as? String
            statusLabel.isEnabled = false
        }
        statusLabel.textColor = .gray
        statusLabel.textAlignment = .right
        statusLabel.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        statusLabel.accessibilityLabel = "Customer Status"
        
        addressTitle.frame.size.width = mainView.frame.width*2/3
        addressTitle.frame.size.height = mainView.frame.height/10
        addressTitle.frame.origin.x = 25
        addressTitle.frame.origin.y = currencyLabel.frame.origin.y + currencyLabel.frame.height
        addressTitle.text = "Address"
        
        addressLabel.frame.size.width = mainView.frame.width - 50
        addressLabel.frame.size.height = mainView.frame.height/10
        addressLabel.frame.origin.x = 25
        addressLabel.frame.origin.y = addressTitle.frame.origin.y + addressTitle.frame.height - 10
        if clientEditing {
            addressLabel.placeholder = "Address"
            addressLabel.isEnabled = true
        }
        else {
            addressLabel.text = client["Domicile"] as? String
            addressLabel.isEnabled = false
        }
        addressLabel.textColor = .gray
        addressLabel.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        addressLabel.accessibilityLabel = "Domicile"
        
        viewOnMapButton.titleLabel?.textAlignment = .right
        viewOnMapButton.setTitleColor(.systemBlue, for: .normal)
        viewOnMapButton.setTitle("View On Map", for: .normal)
        viewOnMapButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        viewOnMapButton.addTarget(self, action: #selector(openMap), for: .touchUpInside)
        viewOnMapButton.sizeToFit()
        viewOnMapButton.frame.origin.x = mainView.frame.width - viewOnMapButton.frame.width - 25
        viewOnMapButton.center.y = addressTitle.center.y
        
        let underlineView1 = UIView()
        underlineView1.frame.size.width = viewOnMapButton.frame.width
        underlineView1.frame.size.height = 1.0
        underlineView1.backgroundColor = .systemBlue
        underlineView1.frame.origin.y = viewOnMapButton.frame.height - 5
        viewOnMapButton.addSubview(underlineView1)
        
        map.frame.size.width = mapView.frame.width - 50
        map.frame.size.height = map.frame.width
        map.frame.origin.x = 25
        map.frame.origin.y = 25
        
        if clientEditing == false {
            location = CLLocationCoordinate2D(latitude: client["Latitude"] as! CLLocationDegrees, longitude: client["Longitude"] as! CLLocationDegrees)
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 500, longitudinalMeters: 500)
            map.setRegion(region, animated: false)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = client["Domicile"] as? String
            annotation.subtitle = "\((client["Name"] as! String) + " " + (client["Surname"] as! String))"
            map.addAnnotation(annotation)
        }
        map.isUserInteractionEnabled = true
        map.isZoomEnabled = true
        
        summaryTitle.frame.size.width = mainView.frame.width
        summaryTitle.frame.size.height = nameLabel.frame.height
        summaryTitle.frame.origin.x = 35
        summaryTitle.frame.origin.y = mainView.frame.origin.y + mainView.frame.height + 10
        summaryTitle.text = "Summary"
        summaryTitle.font = UIFont.systemFont(ofSize: 20)
        
        summaryView1.frame.size.width = (self.view.frame.width - 70 - 20)/3
        summaryView1.frame.size.height = mainView.frame.size.height/5
        summaryView1.frame.origin.x = 35
        summaryView1.frame.origin.y = summaryTitle.frame.origin.y + summaryTitle.frame.height
        summaryView1.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 7.5), opacity: 0.8, shadowRadius: 5, cornerRadius: 10.0, corners: [.allCorners], fillColor: UIColor(red: 14/255, green: 27/255, blue: 56/255, alpha: 1.0))
        
        summaryView2.frame.size.width = (self.view.frame.width - 70 - 20)/3
        summaryView2.frame.size.height = mainView.frame.size.height/5
        summaryView2.frame.origin.x = summaryView1.frame.origin.x + summaryView1.frame.width + 10
        summaryView2.frame.origin.y = summaryTitle.frame.origin.y + summaryTitle.frame.height
        summaryView2.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 7.5), opacity: 0.8, shadowRadius: 5, cornerRadius: 10.0, corners: [.allCorners], fillColor: UIColor(red: 14/255, green: 27/255, blue: 56/255, alpha: 1.0))
        
        summaryView3.frame.size.width = (self.view.frame.width - 70 - 20)/3
        summaryView3.frame.size.height = mainView.frame.size.height/5
        summaryView3.frame.origin.x = summaryView2.frame.origin.x + summaryView2.frame.width + 10
        summaryView3.frame.origin.y = summaryTitle.frame.origin.y + summaryTitle.frame.height
        summaryView3.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 7.5), opacity: 0.8, shadowRadius: 5, cornerRadius: 10.0, corners: [.allCorners], fillColor: UIColor(red: 14/255, green: 27/255, blue: 56/255, alpha: 1.0))
        
        portfoliosTitle.frame.size.width = mainView.frame.width
        portfoliosTitle.frame.size.height = nameLabel.frame.height
        portfoliosTitle.frame.origin.x = 35
        portfoliosTitle.frame.origin.y = summaryView1.frame.origin.y + summaryView1.frame.height + 10
        portfoliosTitle.text = "Portfolios"
        portfoliosTitle.font = UIFont.systemFont(ofSize: 20)
        
        portfoliosScrollView.frame.size.width = self.view.frame.width
        portfoliosScrollView.frame.size.height = self.view.frame.height - portfoliosTitle.frame.origin.y - portfoliosTitle.frame.height - 10
        portfoliosScrollView.frame.origin.y = portfoliosTitle.frame.origin.y + portfoliosTitle.frame.height
        portfoliosScrollView.backgroundColor = .clear
        portfoliosScrollView.showsHorizontalScrollIndicator = false
        portfoliosScrollView.delegate = self
        portfoliosScrollView.contentInset.left = 35
        portfoliosScrollView.contentInset.right = 35
        
        dotsLabel.frame.size.height = 40
        dotsLabel.frame.size.width = mainView.frame.width/3
        dotsLabel.frame.origin.y = portfoliosScrollView.frame.origin.y + portfoliosScrollView.frame.height - 10
        dotsLabel.center.x = mainView.center.x
        dotsLabel.numberOfPages = Int(round(Double(portfoliosScrollView.contentSize.width/portfoliosScrollView.frame.width)))
        dotsLabel.currentPageIndicatorTintColor = .darkGray
        dotsLabel.pageIndicatorTintColor = .lightGray
        
        setupPortfolios()
        
        self.view.addSubview(topBackgroundView)
        topBackgroundView.addSubview(backgroundImage)
        topBackgroundView.addSubview(titleLabel)
        mainView.addSubview(image)
        mainView.addSubview(nameLabel)
        mainView.addSubview(emailLabel)
        mainView.addSubview(emailIcon)
        mainView.addSubview(phoneLabel)
        mainView.addSubview(phoneIcon)
        mainView.addSubview(line1)
        mainView.addSubview(languageTitle)
        mainView.addSubview(languageLabel)
        mainView.addSubview(currencyTitle)
        mainView.addSubview(currencyLabel)
        mainView.addSubview(sectorTitle)
        mainView.addSubview(sectorLabel)
        mainView.addSubview(statusTitle)
        mainView.addSubview(statusLabel)
        mainView.addSubview(addressTitle)
        mainView.addSubview(addressLabel)
        mainView.addSubview(viewOnMapButton)
        mapView.addSubview(map)
        mainScrollView.addSubview(summaryTitle)
        mainScrollView.addSubview(summaryView1)
        mainScrollView.addSubview(summaryView2)
        mainScrollView.addSubview(summaryView3)
        mainScrollView.addSubview(portfoliosTitle)
        mainScrollView.addSubview(portfoliosScrollView)
        mainScrollView.addSubview(dotsLabel)
        mainScrollView.addSubview(mainView)
        mainScrollView.addSubview(mapView)
        
        self.view.addSubview(mainScrollView)
        self.view.addSubview(backButton)
        self.view.addSubview(editButton)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        mainScrollView.addGestureRecognizer(tap)
    }
    
    @objc func openMap(button: UIButton) {
        if button.titleLabel?.text == "View On Map" {
            UIView.animate(withDuration: 0.5, animations: {
                self.mapView.alpha = 1
                self.mapView.frame.origin.y = self.mainView.frame.origin.y + self.addressLabel.frame.origin.y + self.addressLabel.frame.height
            }, completion: {(value) in
                button.setTitle("Done", for: .normal)
                button.sizeToFit()
                button.frame.origin.x = self.mainView.frame.width - self.viewOnMapButton.frame.width - 25
                button.center.y = self.addressTitle.center.y
                (button.subviews[1].frame.size.width) = button.frame.width
            })
        }
        else {
            UIView.animate(withDuration: 0.5, animations: {
                self.mapView.alpha = 0
                self.mapView.frame.origin.y = self.mainView.frame.origin.y + self.mainView.frame.height/2
            }, completion: {(value) in
                button.setTitle("View On Map", for: .normal)
                button.sizeToFit()
                button.frame.origin.x = self.mainView.frame.width - self.viewOnMapButton.frame.width - 25
                button.center.y = self.addressTitle.center.y
                (button.subviews[1].frame.size.width) = button.frame.width
            })
        }
        
    }
    
    func setupPortfolios() {
        for i in 0..<4 {
            let pview = UIView()

            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelectPortfolio(tap:)))
            tap.accessibilityLabel = "\(i)"
            
            pview.addGestureRecognizer(tap)
            pview.frame.size.height = portfoliosScrollView.frame.height - 15
            pview.frame.size.width = portfoliosScrollView.frame.width/2.75
            pview.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 10, height: 5), opacity: 1.0, shadowRadius: 3, cornerRadius: 10.0, corners: [.allCorners], fillColor: .white)
            portfolioViews.append(pview)
        }
        
        portfoliosScrollView.contentSize = CGSize(width: (portfoliosScrollView.frame.width/2.75)*CGFloat(portfolioViews.count)+30*CGFloat(portfolioViews.count-1), height: portfoliosScrollView.frame.height)
        
        for portfolio in 0..<(portfolioViews.count) {
            portfolioViews[portfolio].frame.origin.x = (portfoliosScrollView.frame.width/2.75)*CGFloat(portfolio) + CGFloat(30*portfolio)
            portfoliosScrollView.addSubview(portfolioViews[portfolio])
        }
        
        dotsLabel.numberOfPages = Int(round(Double(portfoliosScrollView.contentSize.width/portfoliosScrollView.frame.width)))
    }
    
    @objc func didSelectPortfolio(tap: UITapGestureRecognizer) {
        let index = Int(tap.accessibilityLabel! as String)!
        
        print(index)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x/scrollView.frame.width
        dotsLabel.currentPage = Int(round(pageNumber))
    }
    
    @objc func textFieldDidChange(textField: UITextField) {
        if changedItems.contains(textField) == false {
            changedItems.append(textField)
        }
        
        if textField.text!.isEmpty {
            textField.attributedPlaceholder = NSAttributedString(string: textField.accessibilityLabel!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
        }
    }
    
    @objc func edit(button: UIButton) {
        if button.titleLabel?.text == "EDIT" {
            clientEditing = true
            button.setTitle("DONE", for: .normal)
            
            nameLabel.isEnabled = true
            emailLabel.isEnabled = true
            phoneLabel.isEnabled = true
            languageLabel.isEnabled = true
            sectorLabel.isEnabled = true
            currencyLabel.isEnabled = true
            statusLabel.isEnabled = true
            addressLabel.isEnabled = true
        }
        else {            
            var blankFields = false
            for item in changedItems {
                if item.text!.isEmpty {
                    blankFields = true
                }
            }
            
            if blankFields == false {
                clientEditing = false
                button.setTitle("EDIT", for: .normal)
                
                nameLabel.isEnabled = false
                emailLabel.isEnabled = false
                phoneLabel.isEnabled = false
                languageLabel.isEnabled = false
                sectorLabel.isEnabled = false
                currencyLabel.isEnabled = false
                statusLabel.isEnabled = false
                addressLabel.isEnabled = false
                
                for item in changedItems {
                    if item.accessibilityLabel == "Full Name" {
                        var spaceIndex = nameLabel.text!.firstIndex(of: " ")!
                        var range = nameLabel.text!.firstIndex(of: nameLabel.text!.first!)!..<spaceIndex
                        let firstName = nameLabel.text![range]
                        spaceIndex = nameLabel.text!.index(after: nameLabel.text!.firstIndex(of: " ")!)
                        range = spaceIndex..<nameLabel.text!.endIndex
                        let lastName = nameLabel.text![range]
                        print(firstName)
                        print(lastName)
                        
                        let ref = Database.database().reference()
                        
                        ref.child("clients").observeSingleEvent(of: .value, with: {(snapshot) in
                            
                            for child in snapshot.children {
                                let clientKey = (child as AnyObject).key as String
                                let value = (child as! DataSnapshot)
                                let fetchedData = value.value as! [String: AnyObject]
                                if fetchedData["Customer ID"] as! Float == self.client["Customer ID"] as! Float {
                                    print("FOUND THE CLIENT")
                                    print(clientKey)
                                    ref.child("clients").child("\(clientKey)").child("Name").setValue(firstName)
                                    ref.child("clients").child("\(clientKey)").child("Surname").setValue(lastName)
                                    break
                                }
                            }
                        })
                        
                    }
                    else {
                        let ref = Database.database().reference()
                        
                        ref.child("clients").observeSingleEvent(of: .value, with: {(snapshot) in
                            
                            for child in snapshot.children {
                                let clientKey = (child as AnyObject).key as String
                                let value = (child as! DataSnapshot)
                                let fetchedData = value.value as! [String: AnyObject]
                                if fetchedData["Customer ID"] as! Float == self.client["Customer ID"] as! Float {
                                    print("FOUND THE CLIENT")
                                    print(clientKey)
                                    ref.child("clients").child("\(clientKey)").child(item.accessibilityLabel!).setValue(item.text)
                                    break
                                }
                            }
                        })
                    }
                }
            }
        }
    }
    
    @objc func back() {
        if clientEditing {
            let alertView = UIAlertController(title: "All changes might be lost!", message: "", preferredStyle: .alert)
            
            alertView.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(action) in
                
            }))
            
            alertView.addAction(UIAlertAction(title: "Leave", style: .destructive, handler: {(action) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alertView, animated: true, completion: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
