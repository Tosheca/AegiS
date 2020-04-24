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
import PieCharts

class SingleClientViewController: UIViewController, UIScrollViewDelegate, PieChartDelegate, UITableViewDelegate, UITableViewDataSource {

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
    var profitabilityTitle = UILabel()
    var profitabilityLabel = UILabel()
    var summaryView2 = UIView()
    var totalSecuritiesTitle = UILabel()
    var totalSecuritiesLabel = UILabel()
    var summaryView3 = UIView()
    var recentChangeTitle = UILabel()
    var changeArrow = UIImageView()
    var recentChangeLabel = UILabel()
    var portfoliosTitle = UILabel()
    var portfoliosSegmentedControl = UISegmentedControl()
    var portfoliosScrollView = UIScrollView()
    var portfolioViews = [UIView]()
    var dotsLabel = UIPageControl()
    
    var clientEditing = false
    var client = [String: AnyObject]()
    var changedItems = [UITextField]()
    
    var portfolios = [[String: AnyObject]]()
    var hasPortfolioGraphView = false
    var portfolioGraphView = UIView()
    var portfolioGraph = PieChart()
    var portfolioGraphTitle = UILabel()
    var selectedSecurities = [Int]()
    var securitiesTableView = UITableView()
    
    var pSecuritiesView = UIView()
    var securityIDs = [String: [String: Int]]()
    var securities = [[String: AnyObject]]()
    var searchedSecurities = [[String: AnyObject]]()
    
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
        backButton.frame.origin.y = 40
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
        mainScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height*1.05)
        mainScrollView.showsVerticalScrollIndicator = false
        mainScrollView.delegate = self
        mainScrollView.tag = 0
        
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
        summaryTitle.font = UIFont.boldSystemFont(ofSize: 20)
        
        summaryView1.frame.size.width = (self.view.frame.width - 70 - 20)/3
        summaryView1.frame.size.height = mainView.frame.size.height/5
        summaryView1.frame.origin.x = 35
        summaryView1.frame.origin.y = summaryTitle.frame.origin.y + summaryTitle.frame.height
        summaryView1.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 7.5), opacity: 0.8, shadowRadius: 5, cornerRadius: 10.0, corners: [.allCorners], fillColor: UIColor(red: 14/255, green: 27/255, blue: 56/255, alpha: 1.0))
        
        profitabilityTitle.frame.size.width = summaryView1.frame.width
        profitabilityTitle.frame.size.height = summaryView1.frame.height/3
        profitabilityTitle.center.y = summaryView1.frame.height/4
        profitabilityTitle.textColor = .white
        profitabilityTitle.text = "Profitability"
        profitabilityTitle.textAlignment = .center
        profitabilityTitle.font = UIFont.boldSystemFont(ofSize: 13)
        summaryView1.addSubview(profitabilityTitle)
        
        profitabilityLabel.frame.size.width = summaryView1.frame.width
        profitabilityLabel.frame.size.height = summaryView1.frame.height/2
        profitabilityLabel.center.y = summaryView1.frame.height*3/5
        profitabilityLabel.textAlignment = .center
        profitabilityLabel.font = UIFont.boldSystemFont(ofSize: 25)
        summaryView1.addSubview(profitabilityLabel)
        profitabilityLabel.text = "6.8%"
        profitabilityLabel.adjustsFontSizeToFitWidth = true
        profitabilityLabel.textColor = .green
        
        summaryView2.frame.size.width = (self.view.frame.width - 70 - 20)/3
        summaryView2.frame.size.height = mainView.frame.size.height/5
        summaryView2.frame.origin.x = summaryView1.frame.origin.x + summaryView1.frame.width + 10
        summaryView2.frame.origin.y = summaryTitle.frame.origin.y + summaryTitle.frame.height
        summaryView2.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 7.5), opacity: 0.8, shadowRadius: 5, cornerRadius: 10.0, corners: [.allCorners], fillColor: UIColor(red: 14/255, green: 27/255, blue: 56/255, alpha: 1.0))
        
        totalSecuritiesTitle.frame.size.width = summaryView2.frame.width
        totalSecuritiesTitle.frame.size.height = summaryView2.frame.height/3
        totalSecuritiesTitle.center.y = summaryView2.frame.height/4
        totalSecuritiesTitle.textColor = .white
        totalSecuritiesTitle.text = "Total Securities"
        totalSecuritiesTitle.textAlignment = .center
        totalSecuritiesTitle.font = UIFont.boldSystemFont(ofSize: 13)
        summaryView2.addSubview(totalSecuritiesTitle)
        
        totalSecuritiesLabel.frame.size.width = summaryView2.frame.width
        totalSecuritiesLabel.frame.size.height = summaryView2.frame.height/2
        totalSecuritiesLabel.center.y = summaryView2.frame.height*3/5
        totalSecuritiesLabel.textAlignment = .center
        totalSecuritiesLabel.font = UIFont.boldSystemFont(ofSize: 25)
        summaryView2.addSubview(totalSecuritiesLabel)
        totalSecuritiesLabel.text = ""
        totalSecuritiesLabel.adjustsFontSizeToFitWidth = true
        totalSecuritiesLabel.textColor = .white
        
        summaryView3.frame.size.width = (self.view.frame.width - 70 - 20)/3
        summaryView3.frame.size.height = mainView.frame.size.height/5
        summaryView3.frame.origin.x = summaryView2.frame.origin.x + summaryView2.frame.width + 10
        summaryView3.frame.origin.y = summaryTitle.frame.origin.y + summaryTitle.frame.height
        summaryView3.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 7.5), opacity: 0.8, shadowRadius: 5, cornerRadius: 10.0, corners: [.allCorners], fillColor: UIColor(red: 14/255, green: 27/255, blue: 56/255, alpha: 1.0))
        
        recentChangeTitle.frame.size.width = summaryView3.frame.width
        recentChangeTitle.frame.size.height = summaryView3.frame.height/3
        recentChangeTitle.center.y = summaryView3.frame.height/4
        recentChangeTitle.textColor = .white
        recentChangeTitle.text = "Recent change"
        recentChangeTitle.textAlignment = .center
        recentChangeTitle.font = UIFont.boldSystemFont(ofSize: 13)
        summaryView3.addSubview(recentChangeTitle)
        
        recentChangeLabel.frame.size.height = summaryView3.frame.height/4
        recentChangeLabel.frame.size.width = summaryView3.frame.width - recentChangeLabel.frame.size.height - 10
        recentChangeLabel.center.y = summaryView3.frame.height*3/5
        recentChangeLabel.frame.origin.x = recentChangeLabel.frame.size.height + 5
        recentChangeLabel.textAlignment = .center
        recentChangeLabel.font = UIFont.boldSystemFont(ofSize: 25)
        summaryView3.addSubview(recentChangeLabel)
        recentChangeLabel.text = "£21235,00"
        recentChangeLabel.adjustsFontSizeToFitWidth = true
        recentChangeLabel.textColor = .red
        
        changeArrow = UIImageView(image: UIImage(systemName: "arrow.down"))
        changeArrow.frame.size.height = summaryView3.frame.height/4
        changeArrow.frame.size.width = changeArrow.frame.height
        changeArrow.center.y = recentChangeLabel.center.y
        changeArrow.frame.origin.x = recentChangeLabel.frame.origin.x - changeArrow.frame.width
        changeArrow.tintColor = .red
        summaryView3.addSubview(changeArrow)
        
        portfoliosTitle.frame.size.width = mainView.frame.width
        portfoliosTitle.frame.size.height = nameLabel.frame.height
        portfoliosTitle.frame.origin.x = 35
        portfoliosTitle.frame.origin.y = summaryView1.frame.origin.y + summaryView1.frame.height + 10
        portfoliosTitle.text = "Portfolios"
        portfoliosTitle.font = UIFont.boldSystemFont(ofSize: 20)
        
        portfoliosSegmentedControl = UISegmentedControl(items: ["All", "Open", "Close"])
        portfoliosSegmentedControl.frame.size.width = mainView.frame.width/2
        portfoliosSegmentedControl.frame.size.height = portfoliosTitle.frame.height
        portfoliosSegmentedControl.frame.origin.y = portfoliosTitle.frame.origin.y + portfoliosTitle.frame.height
        portfoliosSegmentedControl.frame.origin.x = 35
        portfoliosSegmentedControl.selectedSegmentIndex = 0
        portfoliosSegmentedControl.addTarget(self, action: #selector(segmentUpdate), for: .valueChanged)
        
        portfoliosScrollView.frame.size.width = self.view.frame.width
        portfoliosScrollView.frame.size.height = self.view.frame.height - portfoliosSegmentedControl.frame.origin.y - portfoliosSegmentedControl.frame.height - 10
        portfoliosScrollView.frame.origin.y = portfoliosSegmentedControl.frame.origin.y + portfoliosSegmentedControl.frame.height + 10
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
        mainScrollView.addSubview(portfoliosSegmentedControl)
        mainScrollView.addSubview(portfoliosScrollView)
        mainScrollView.addSubview(dotsLabel)
        mainScrollView.addSubview(mainView)
        mainScrollView.addSubview(mapView)
        
        self.view.addSubview(mainScrollView)
        self.view.addSubview(backButton)
        self.view.addSubview(editButton)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //mainScrollView.addGestureRecognizer(tap)
        
        fetchPortfolios()
        
        securitiesTableView.delegate = self
        securitiesTableView.dataSource = self
        securitiesTableView.register(SecuritiesTableViewCell.self, forCellReuseIdentifier: "pSecurity")
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
        for pindex in 0..<portfolios.count {
            
            if (portfoliosSegmentedControl.selectedSegmentIndex == 1 && portfolios[pindex]["STATUS"] as! String == "Open") || (portfoliosSegmentedControl.selectedSegmentIndex == 2 && portfolios[pindex]["STATUS"] as! String == "Close") || (portfoliosSegmentedControl.selectedSegmentIndex == 0) {
                
                let pview = UIView()

                let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelectPortfolio(tap:)))
                tap.accessibilityLabel = "\(pindex)"
                
                pview.addGestureRecognizer(tap)
                pview.frame.size.height = portfoliosScrollView.frame.height - 15
                pview.frame.size.width = mainView.frame.width*1/2
                
                pview.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 10, height: 5), opacity: 1.0, shadowRadius: 3, cornerRadius: 10.0, corners: [.allCorners], fillColor: .white)
                
                let initialValueTitle = UILabel()
                initialValueTitle.frame.size.width = pview.frame.width - 20
                initialValueTitle.frame.size.height = pview.frame.height/10
                initialValueTitle.frame.origin.y = 5
                initialValueTitle.frame.origin.x = 10
                initialValueTitle.text = "Initial value"
                initialValueTitle.textColor = .gray
                pview.addSubview(initialValueTitle)
                
                let initialValueLabel = UILabel()
                initialValueLabel.frame.size.width = pview.frame.width - 20
                initialValueLabel.frame.size.height = pview.frame.height/8
                initialValueLabel.frame.origin.y = initialValueTitle.frame.origin.y + initialValueTitle.frame.height - 5
                initialValueLabel.frame.origin.x = 10
                initialValueLabel.text = "£\(portfolios[pindex]["Initial Value"] as! String)"
                initialValueLabel.adjustsFontSizeToFitWidth = true
                initialValueLabel.textColor = .black
                initialValueLabel.font = UIFont.boldSystemFont(ofSize: 25)
                pview.addSubview(initialValueLabel)
                
                let typeTitle = UILabel()
                typeTitle.frame.size.width = pview.frame.width - 20
                typeTitle.frame.size.height = pview.frame.height/10
                typeTitle.frame.origin.y = initialValueLabel.frame.origin.y + initialValueLabel.frame.height + 10
                typeTitle.frame.origin.x = 10
                typeTitle.text = "Type"
                typeTitle.textColor = .gray
                pview.addSubview(typeTitle)
                
                let typeLabel = UILabel()
                typeLabel.frame.size.width = pview.frame.width - 20
                typeLabel.frame.size.height = pview.frame.height/8
                typeLabel.frame.origin.y = typeTitle.frame.origin.y + typeTitle.frame.height - 5
                typeLabel.frame.origin.x = 10
                let type = portfolios[pindex]["Type"] as? String
                if type == "EXE" {
                    typeLabel.text = "Execution-Only"
                }
                else if type == "ADV" {
                    typeLabel.text = "Advisory"
                }
                typeLabel.adjustsFontSizeToFitWidth = true
                typeLabel.textColor = .black
                typeLabel.font = UIFont.systemFont(ofSize: 20)
                pview.addSubview(typeLabel)
                
                let feeCodeTitle = UILabel()
                feeCodeTitle.frame.size.width = pview.frame.width - 20
                feeCodeTitle.frame.size.height = pview.frame.height/10
                feeCodeTitle.frame.origin.y = typeLabel.frame.origin.y + typeLabel.frame.height + 10
                feeCodeTitle.frame.origin.x = 10
                feeCodeTitle.text = "Fee Code"
                feeCodeTitle.textColor = .gray
                pview.addSubview(feeCodeTitle)
                
                let feeCodeLabel = UILabel()
                feeCodeLabel.frame.size.width = pview.frame.width - 20
                feeCodeLabel.frame.size.height = pview.frame.height/8
                feeCodeLabel.frame.origin.y = feeCodeTitle.frame.origin.y + feeCodeTitle.frame.height - 5
                feeCodeLabel.frame.origin.x = 10
                feeCodeLabel.text = portfolios[pindex]["Fee Code"] as? String
                feeCodeLabel.adjustsFontSizeToFitWidth = true
                feeCodeLabel.textColor = .black
                pview.addSubview(feeCodeLabel)
                
                let statusTitle = UILabel()
                statusTitle.frame.size.width = pview.frame.width - 20
                statusTitle.frame.size.height = pview.frame.height/10
                statusTitle.frame.origin.y = typeLabel.frame.origin.y + typeLabel.frame.height + 10
                statusTitle.frame.origin.x = 10
                statusTitle.text = "Status"
                statusTitle.textColor = .gray
                statusTitle.textAlignment = .right
                pview.addSubview(statusTitle)
                
                let statusLabel = UILabel()
                statusLabel.frame.size.width = pview.frame.width - 20
                statusLabel.frame.size.height = pview.frame.height/8
                statusLabel.frame.origin.y = statusTitle.frame.origin.y + statusTitle.frame.height - 5
                statusLabel.frame.origin.x = 10
                statusLabel.text = portfolios[pindex]["STATUS"] as? String
                statusLabel.adjustsFontSizeToFitWidth = true
                statusLabel.textColor = .black
                statusLabel.textAlignment = .right
                pview.addSubview(statusLabel)
                
                let showInfoButton = UIButton()
                showInfoButton.frame.size.width = pview.frame.width
                showInfoButton.frame.size.height = pview.frame.height/8
                showInfoButton.setTitle("Show more info", for: .normal)
                showInfoButton.sizeToFit()
                showInfoButton.addTarget(self, action: #selector(closeGraphView(button:)), for: .touchUpInside)
                showInfoButton.frame.origin.y = statusLabel.frame.origin.y + statusLabel.frame.height + 10
                showInfoButton.center.x = pview.frame.width/2
                showInfoButton.setTitleColor(.systemBlue, for: .normal)
                showInfoButton.isEnabled = false
                showInfoButton.tag = pindex
                pview.addSubview(showInfoButton)
                
                let underlineView1 = UIView()
                underlineView1.frame.size.width = showInfoButton.frame.width
                underlineView1.frame.size.height = 1.0
                underlineView1.backgroundColor = .systemBlue
                underlineView1.frame.origin.y = showInfoButton.frame.height - 5
                showInfoButton.addSubview(underlineView1)
                
                portfolioViews.append(pview)
            }
            else {
                print("no portfolios available")
                let info = UILabel()
                info.frame.size.width = mainView.frame.width
                info.frame.size.height = portfoliosScrollView.frame.height/4
                info.center.y = portfoliosScrollView.frame.height/2
                info.text = "No portfolios available"
                info.font = UIFont.systemFont(ofSize: 25)
                info.textAlignment = .center
                portfoliosScrollView.addSubview(info)
            }
        }
        
        portfoliosScrollView.contentSize = CGSize(width: (mainView.frame.width*1/2)*CGFloat(portfolioViews.count)+30*CGFloat(portfolioViews.count-1), height: portfoliosScrollView.frame.height)
        
        for portfolio in 0..<(portfolioViews.count) {
            portfolioViews[portfolio].frame.origin.x = (mainView.frame.width*1/2)*CGFloat(portfolio) + CGFloat(30*portfolio)
            portfoliosScrollView.addSubview(portfolioViews[portfolio])
        }
        
        dotsLabel.numberOfPages = Int(round(Double(portfoliosScrollView.contentSize.width/portfoliosScrollView.frame.width)))
    }
    
    @objc func segmentUpdate(){
        print("segment update")
        portfolioViews.removeAll()
        for sview in portfoliosScrollView.subviews {
            sview.removeFromSuperview()
        }
        setupPortfolios()
    }
    
    @objc func didSelectPortfolio(tap: UITapGestureRecognizer) {
        let index = Int(tap.accessibilityLabel! as String)!
        
        print(index)
        if hasPortfolioGraphView == false {
            portfoliosScrollView.setContentOffset(CGPoint(x: (mainView.frame.width*1/2)*CGFloat(index) + CGFloat(30*index) - 35, y: 0), animated: true)
            
            let parentView = portfolioViews[index]
            
            for subview in portfolioGraphView.subviews {
                subview.removeFromSuperview()
            }
            portfolioGraphView.frame.size.width = parentView.frame.width + 10
            portfolioGraphView.frame.size.height = parentView.frame.height
            portfolioGraphView.frame.origin.x = parentView.frame.origin.x
            if portfolioGraphView.layer.sublayers?.count == nil {
                portfolioGraphView.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 10, height: 5), opacity: 1.0, shadowRadius: 3, cornerRadius: 10.0, corners: [.topRight, .bottomRight], fillColor: .white)
            }
            portfolioGraphView.alpha = 0

            for subview in portfolioGraph.subviews {
                subview.removeFromSuperview()
            }
            
            for subview in pSecuritiesView.subviews {
                subview.removeFromSuperview()
            }
            
            portfolioGraph = PieChart()
            portfolioGraph.frame.size.width = portfolioGraphView.frame.width - 10
            portfolioGraph.frame.size.height = portfolioGraph.frame.width
            portfolioGraph.center.x = portfolioGraphView.frame.width/2
            portfolioGraph.center.y = portfolioGraphView.frame.height/2
            portfolioGraph.outerRadius = portfolioGraph.frame.width/2
            portfolioGraph.innerRadius = portfolioGraph.frame.width/4
            portfolioGraph.strokeWidth = 1
            portfolioGraph.strokeColor = .white
            portfolioGraph.selectedOffset = 7
            portfolioGraph.delegate = self
            
            var gModels = [PieSliceModel]()
            for security in 0..<securityIDs[portfolios[index]["PORTFOLIO ID"] as! String]!.count {
                let red = Double((10+10*(security+1))/255)
                let green = CGFloat((20+10*(security+1))/255)
                let blue = CGFloat((30 + 10*(security+1))/255)
                let value = securityIDs[portfolios[index]["PORTFOLIO ID"] as! String]![Array(securityIDs[portfolios[index]["PORTFOLIO ID"] as! String]!.keys)[security]]
                let model = PieSliceModel(value: Double(value!), color: UIColor(red: CGFloat((10+10*security)/255), green: CGFloat((20+10*security)/255), blue: CGFloat(Double(75+10*(security+1))/255.0), alpha: 1.0))
                gModels.append(model)
                print(red)
                print(green)
                print(blue)
                print(Double(75+10*(security+1))/255.0)
            }
            portfolioGraph.models = gModels
            portfolioGraphView.addSubview(portfolioGraph)
            
            selectedSecurities.removeAll()
            
            portfolioGraphTitle.frame.size.width = portfolioGraph.innerRadius*2 - 10
            portfolioGraphTitle.frame.size.height = portfolioGraphTitle.frame.width
            portfolioGraphTitle.center.x = portfolioGraph.frame.width/2
            portfolioGraphTitle.center.y = portfolioGraph.frame.height/2
            portfolioGraphTitle.text = ""
            portfolioGraphTitle.textAlignment = .center
            portfolioGraphTitle.font = UIFont.boldSystemFont(ofSize: 25)
            portfolioGraphTitle.adjustsFontSizeToFitWidth = true
            portfolioGraph.addSubview(portfolioGraphTitle)
            
            pSecuritiesView.frame.size.width = parentView.frame.width*2
            pSecuritiesView.frame.size.height = parentView.frame.height + 10
            pSecuritiesView.frame.origin.x = parentView.frame.origin.x
            if pSecuritiesView.layer.sublayers?.count == nil {
                pSecuritiesView.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 10, height: 5), opacity: 1.0, shadowRadius: 3, cornerRadius: 10.0, corners: [.bottomLeft, .bottomRight], fillColor: .white)
            }
            pSecuritiesView.alpha = 0
            
            let sLabel = UILabel()
            sLabel.frame.size.width = pSecuritiesView.frame.width
            sLabel.frame.size.height = pSecuritiesView.frame.height/10
            sLabel.textAlignment = .center
            sLabel.center.x = pSecuritiesView.frame.width/2
            sLabel.frame.origin.y = 5
            sLabel.text = "Securities"
            sLabel.textColor = .black
            pSecuritiesView.addSubview(sLabel)
            
            securitiesTableView.removeFromSuperview()
            securitiesTableView.frame.size.width = pSecuritiesView.frame.width - 50
            securitiesTableView.frame.size.height = pSecuritiesView.frame.height - sLabel.frame.height - 20
            securitiesTableView.frame.origin.y = sLabel.frame.origin.y + sLabel.frame.height + 5
            securitiesTableView.frame.origin.x = 25
            pSecuritiesView.addSubview(securitiesTableView)
            
            fetchSecurities(portfolioID: portfolios[index]["PORTFOLIO ID"] as! String)
            
            portfoliosScrollView.addSubview(portfolioGraphView)
            portfoliosScrollView.addSubview(pSecuritiesView)
            portfoliosScrollView.isScrollEnabled = false
            
            mainScrollView.contentSize = CGSize(width: mainScrollView.contentSize.width, height: mainScrollView.contentSize.height + parentView.frame.height)
            portfoliosScrollView.frame.size.height = portfoliosScrollView.frame.height + parentView.frame.height
            dotsLabel.frame.origin.y = portfoliosScrollView.frame.origin.y + portfoliosScrollView.frame.height - 10
            
            hasPortfolioGraphView = true

            let infoButton = parentView.subviews[8] as! UIButton
            infoButton.setTitle("Hide more info", for: .normal)
            infoButton.isEnabled = true
            
            portfoliosSegmentedControl.isEnabled = false
            
            UIView.animate(withDuration: 0.5, animations: {
                self.portfolioGraphView.alpha = 1
                self.portfolioGraphView.frame.origin.x = parentView.frame.origin.x + parentView.frame.width - 10
                
                self.pSecuritiesView.alpha = 1
                self.pSecuritiesView.frame.origin.y = parentView.frame.height - 10
                
            }, completion: {(value) in
                self.mainScrollView.setContentOffset(CGPoint(x: self.mainScrollView.contentOffset.x, y: self.mainScrollView.contentOffset.y + parentView.frame.height), animated: true)
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pSecurity", for: indexPath) as! SecuritiesTableViewCell
        var currentSecurity = securities[indexPath.row]
        if selectedSecurities.isEmpty == false {
            currentSecurity = searchedSecurities[indexPath.row]
        }
        
        cell.selectionStyle = .none
        cell.title.frame.size.height = cell.frame.height
        cell.title.frame.size.width = cell.frame.width*3/5
        cell.title.frame.origin.x = 15
        cell.title.text = currentSecurity["Short description"] as? String
        cell.title.font = UIFont.boldSystemFont(ofSize: 15)
        
        cell.arrow.frame.size.height = cell.frame.height
        cell.arrow.frame.size.width = 30
        cell.arrow.frame.origin.x = cell.frame.width - 40
        cell.arrow.image = UIImage(systemName: "arrow.up")
        cell.arrow.tintColor = .red
        cell.arrow.contentMode = .scaleAspectFit
        
        if (currentSecurity["Price 5"] as! Int) >= (currentSecurity["Price 4"] as! Int) { // price going up
            cell.arrow.tintColor = .green
        }
        else {
            cell.arrow.tintColor = .red
            cell.arrow.transform = CGAffineTransform(rotationAngle: .pi)
        }
        
        cell.price.frame.size.height = cell.frame.height/3
        cell.price.frame.size.width = cell.frame.width - cell.arrow.frame.width - 10 - cell.title.frame.width - 15
        cell.price.frame.origin.x = cell.title.frame.origin.x + cell.title.frame.width
        cell.price.frame.origin.y = 15
        cell.price.textAlignment = .center
        cell.price.text = "£\((currentSecurity["Price 5"] as! Int))"
        cell.price.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.percentage.frame.size = cell.price.frame.size
        cell.percentage.frame.origin.x = cell.price.frame.origin.x
        cell.percentage.frame.origin.y = cell.price.frame.origin.y + cell.price.frame.height
        cell.percentage.textColor = .red
        cell.percentage.textAlignment = .center
        cell.percentage.adjustsFontSizeToFitWidth = true
        
        let percentageChange = ((currentSecurity["Price 5"] as! Double) - (currentSecurity["Price 4"] as! Double))/(currentSecurity["Price 4"] as! Double)*100
        cell.percentage.text = "\(String(format: "%.2f", percentageChange))%"
        
        if percentageChange >= 0 {
            cell.percentage.textColor = .green
            cell.percentage.text = "+" + cell.percentage.text!
        }
        else {
            cell.percentage.textColor = .red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedSecurities.isEmpty {
            return securities.count
        }
        else {
            return selectedSecurities.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select")
        let securityVC = SecurityViewController()
        if selectedSecurities.isEmpty {
            securityVC.security = securities[indexPath.row]
        }
        else {
            securityVC.security = searchedSecurities[indexPath.row]
        }
        securityVC.modalPresentationStyle = .fullScreen
        self.present(securityVC, animated: true, completion: nil)
    }
    
    func onSelected(slice: PieSlice, selected: Bool) {
        var selectedPercentage = 0.0
        selectedSecurities.removeAll()
        searchedSecurities.removeAll()
        for gSlice in portfolioGraph.slices {
            if gSlice.view.selected {
                selectedPercentage =  selectedPercentage + gSlice.data.percentage*100
                selectedSecurities.append(gSlice.data.id)
                searchedSecurities.append(securities[gSlice.data.id])
            }
        }
        if selectedPercentage > 0 {
            portfolioGraphTitle.text = "\(String(format: "%.2f", selectedPercentage))%"
        }
        else {
            portfolioGraphTitle.text = ""
        }
        print(selectedSecurities)
        securitiesTableView.reloadData()
    }
    
    @objc func closeGraphView(button: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.portfolioGraphView.alpha = 0
            self.portfolioGraphView.frame.origin.x = self.portfolioViews[button.tag].frame.origin.x
            self.pSecuritiesView.alpha = 0
            self.pSecuritiesView.frame.origin.y = self.portfolioViews[button.tag].frame.origin.y
            
            self.mainScrollView.contentSize = CGSize(width: self.mainScrollView.contentSize.width, height: self.mainScrollView.contentSize.height - self.portfolioViews[button.tag].frame.height)
            self.portfoliosScrollView.frame.size.height = self.portfoliosScrollView.frame.height - self.portfolioViews[button.tag].frame.height
            self.dotsLabel.frame.origin.y = self.portfoliosScrollView.frame.origin.y + self.portfoliosScrollView.frame.height - 10
        }, completion: {(value) in
            self.hasPortfolioGraphView = false
            button.setTitle("Show more info", for: .normal)
            button.isEnabled = false
            self.portfoliosScrollView.isScrollEnabled = true
            self.portfoliosSegmentedControl.isEnabled = true
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 0 {
            if topBackgroundView.frame.contains(topBackgroundView.convert(summaryTitle.center, from: mainScrollView)) {
                summaryTitle.textColor = .white
            }
            else {
                summaryTitle.textColor = .black
            }
            
            if topBackgroundView.frame.contains(topBackgroundView.convert(portfoliosTitle.center, from: mainScrollView)) {
                portfoliosTitle.textColor = .white
            }
            else {
                portfoliosTitle.textColor = .black
            }
        }
        else {
            let pageNumber = scrollView.contentOffset.x/scrollView.frame.width
            dotsLabel.currentPage = Int(round(pageNumber))
        }
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
    
    func fetchSecurities(portfolioID: String) {
        securities.removeAll()
        let ref = Database.database().reference()
        
        ref.child("securities").observeSingleEvent(of: .value, with: {(snapshot) in
            let s = snapshot.value as! [[String: AnyObject]]
            let keys = Array(self.securityIDs[portfolioID]!.keys) as [String]
            
            for sec in s {
                if (keys.contains(sec["Security code"] as! String)) {
                    self.securities.append(sec)
                }
            }
            
            print(self.securities)
            self.securitiesTableView.reloadData()
        })
    }
    
    func fetchSecurityIDs() {
        let ref = Database.database().reference()
        
        ref.child("trades").observeSingleEvent(of: .value, with: {(snapshot) in
            let trades = snapshot.value as! [AnyObject]
            for pf in self.portfolios {
                self.securityIDs[pf["PORTFOLIO ID"] as! String] = ["":0]
            }
            for trade in trades {
                for pf in self.portfolios {
                    if trade.value(forKey: "Portfolio ID") as! String == pf["PORTFOLIO ID"] as! String {
                        if self.securityIDs[pf["PORTFOLIO ID"] as! String]!.keys.contains(trade.value(forKey: "Security ID") as! String) == false {
                            self.securityIDs[pf["PORTFOLIO ID"] as! String]![trade.value(forKey: "Security ID") as! String] = 1
                        }
                        else {
                            self.securityIDs[pf["PORTFOLIO ID"] as! String]![trade.value(forKey: "Security ID") as! String] = self.securityIDs[pf["PORTFOLIO ID"] as! String]![trade.value(forKey: "Security ID") as! String]! as Int + 1
                        }
                    }
                }
            }
            print(self.securityIDs)
            
            var uniqueIDs = [String]()
            for pf in self.portfolios {
                self.securityIDs[pf["PORTFOLIO ID"] as! String]?.removeValue(forKey: "")
                for key in Array(self.securityIDs[pf["PORTFOLIO ID"] as! String]!.keys) {
                    if uniqueIDs.contains(key) == false {
                        uniqueIDs.append(key)
                    }
                }
            }
            self.totalSecuritiesLabel.text = "\(uniqueIDs.count)"
        })
    }
    
    func fetchPortfolios() {
        let ref = Database.database().reference()
        
        ref.child("portfolios").observeSingleEvent(of: .value, with: {(snapshot) in
            let p = snapshot.value as! [AnyObject]
            
            for pf in p {
                if pf.value(forKey: "CUSTOMER ID") as! Float == self.client["Customer ID"] as! Float {
                    self.portfolios.append(pf as! [String : AnyObject])
                }
            }
            
            print(self.portfolios)
            self.setupPortfolios()
            self.fetchSecurityIDs()
        })
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
