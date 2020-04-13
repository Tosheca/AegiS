//
//  SingleClientViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 4/12/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit
import FirebaseStorage

class SingleClientViewController: UIViewController {

    var backgroundImage = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var topBackgroundView = UIView()
    var backButton = UIButton()
    var titleLabel = UILabel()
    var mainView = UIView()
    var nameLabel = UILabel()
    var emailLabel = UILabel()
    var emailIcon = UIImageView(image: UIImage(systemName: "person.fill"))
    var phoneLabel = UILabel()
    var phoneIcon = UIImageView(image: UIImage(systemName: "phone.fill"))
    var image = UIImageView()
    var line1 = UIView()
    var languageTitle = UILabel()
    var languageLabel = UILabel()
    var currencyTitle = UILabel()
    var currencyLabel = UILabel()
    var sectorTitle = UILabel()
    var sectorLabel = UILabel()
    var statusTitle = UILabel()
    var statusLabel = UILabel()
    var addressTitle = UILabel()
    var addressLabel = UILabel()
    var viewOnMapButton = UIButton()
    
    var client = [String: AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        
        titleLabel.frame.size.width = self.view.frame.width
        titleLabel.frame.size.height = self.view.frame.height/15
        titleLabel.text = "CLIENT"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.frame.origin.y = 40
        
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium)
        let homeImage = UIImage(systemName: "arrow.uturn.left", withConfiguration: homeSymbolConfiguration)
        backButton.setImage(homeImage, for: .normal)
        
        mainView.frame.size.width = self.view.frame.width - 50 - 20
        mainView.frame.size.height = self.view.frame.height*3/7
        mainView.frame.origin.x = 35
        mainView.center.y = topBackgroundView.frame.origin.y + topBackgroundView.frame.height
        mainView.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 7.5), opacity: 0.8, shadowRadius: 5, cornerRadius: 10.0, corners: [.allCorners], fillColor: .white)
        
        image.frame.size.width = mainView.frame.width/4
        image.frame.size.height = image.frame.width
        image.frame.origin.x = mainView.frame.width - image.frame.width - 25
        image.frame.origin.y = -image.frame.height/2
        image.layer.cornerRadius = image.frame.width/2
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 1
        image.contentMode = .scaleAspectFill
        image.image = client["Image"] as? UIImage
        
        nameLabel.frame.size.width = mainView.frame.width*2/3
        nameLabel.frame.size.height = mainView.frame.height/8
        nameLabel.frame.origin.x = 25
        nameLabel.frame.origin.y = 25
        nameLabel.text = "\((client["Name"] as! String) + " " + (client["Surname"] as! String))"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        emailLabel.frame.size.width = mainView.frame.width*2/3
        emailLabel.frame.size.height = mainView.frame.height/10
        emailLabel.frame.origin.y = nameLabel.frame.origin.y + nameLabel.frame.height
        emailLabel.textColor = .gray
        emailLabel.text = "\(client["Email"] as! String)"
        
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
        phoneLabel.text = "0888655396"
        
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
        languageLabel.frame.origin.y = languageTitle.frame.origin.y + languageTitle.frame.height - 5
        languageLabel.text = client["Language of Reporting"] as? String
        languageLabel.textColor = .gray
        
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
        sectorLabel.text = client["Sector"] as? String
        sectorLabel.textColor = .gray
        sectorLabel.textAlignment = .right
        
        currencyTitle.frame.size.width = mainView.frame.width*2/3
        currencyTitle.frame.size.height = mainView.frame.height/10
        currencyTitle.frame.origin.x = 25
        currencyTitle.frame.origin.y = languageLabel.frame.origin.y + languageLabel.frame.height + 10
        currencyTitle.text = "Reporting Currency"
        
        currencyLabel.frame.size.width = mainView.frame.width*2/3
        currencyLabel.frame.size.height = mainView.frame.height/10
        currencyLabel.frame.origin.x = 25
        currencyLabel.frame.origin.y = currencyTitle.frame.origin.y + currencyTitle.frame.height - 5
        currencyLabel.text = client["Reporting Currency"] as? String
        currencyLabel.textColor = .gray
        
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
        statusLabel.text = client["Customer Status"] as? String
        statusLabel.textColor = .gray
        statusLabel.textAlignment = .right
        
        addressTitle.frame.size.width = mainView.frame.width*2/3
        addressTitle.frame.size.height = mainView.frame.height/10
        addressTitle.frame.origin.x = 25
        addressTitle.frame.origin.y = currencyLabel.frame.origin.y + currencyLabel.frame.height + 10
        addressTitle.text = "Address"
        
        self.view.addSubview(topBackgroundView)
        topBackgroundView.addSubview(backgroundImage)
        topBackgroundView.addSubview(backButton)
        topBackgroundView.addSubview(titleLabel)
        self.view.addSubview(mainView)
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
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
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
