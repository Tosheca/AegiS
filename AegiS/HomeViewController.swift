//
//  HomeViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/10/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class HomeViewController: UIViewController, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var mainView = UIView()
    var myClientsLabel = UILabel()
    var clientsScrollView = UIScrollView()
    var clientViews = [UIView]()
    var securitiesOfClientsLabel = UILabel()
    var backgroundImage = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var infoButton = UIButton()
    var helloLabel = UILabel()
    var managerNameLabel = UILabel()
    var securitiesTableView = UITableView()
    var managerImage = UIButton()
    var logoTitle = UILabel()
    var dotsLabel = UIPageControl()
    var clientsSeeAll = UIButton()
    var securitiesSeeAll = UIButton()
    var line1 = UIView()
    var line2 = UIView()
    
    var securityPrices = [Double]()
    var securityPercentages = [Double]()
    
    var managerView = UIView()
    var managerDetailsTitle = UILabel()
    var doneButton = UIButton()
    var emailTitle = UILabel()
    var emailTextField = UITextField()
    var editEmailButton = UIButton()
    var clientsTitle = UILabel()
    var numberOfClientsLabel = UILabel()
    var managerDetailsImage = UIImageView(image: UIImage(named: "89762769_223800988749873_7596640348722429952_n.jpg"))
    var passwordTitle = UILabel()
    var passwordButton = UIButton()
    var managerLine1 = UIView()
    var managerLine2 = UIView()
    var managerLine3 = UIView()
    
    var clients = [[String: AnyObject]]()
    var securities = [[String: AnyObject]]()

    var managerID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //for disabling dark mode
        //self.overrideUserInterfaceStyle = .light
        self.overrideUserInterfaceStyle = .light
        self.edgesForExtendedLayout = []
        
        managerID = UserDefaults.standard.value(forKey: "rmID") as! Int
        print("Manager ID: \(managerID)")
        //self.view.backgroundColor = UIColor(red: 10/255, green: 22/255, blue: 46/255, alpha: 1.0)
        
        backgroundImage.frame.size = self.view.frame.size
        backgroundImage.contentMode = .scaleAspectFill
        
        mainView.frame.size.width = self.view.frame.width
        mainView.frame.size.height = self.view.frame.height*4.5/7
        mainView.frame.origin.y = self.view.frame.height - mainView.frame.height - 83
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 40
        mainView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        mainView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        myClientsLabel.frame.size.width = mainView.frame.width/2
        myClientsLabel.frame.size.height = mainView.frame.height/15
        myClientsLabel.text = "My clients"
        myClientsLabel.frame.origin.x = 25
        myClientsLabel.frame.origin.y = 30
        myClientsLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        clientsScrollView.frame.size.width = mainView.frame.width
        clientsScrollView.frame.size.height = mainView.frame.height/3 + 15
        clientsScrollView.frame.origin.y = 30 + myClientsLabel.frame.height + 10
        clientsScrollView.backgroundColor = .clear
        clientsScrollView.showsHorizontalScrollIndicator = false
        clientsScrollView.delegate = self
        clientsScrollView.contentInset.left = 25
        
        setupClientViews()
        
        securitiesOfClientsLabel.frame.size.width = mainView.frame.width/1.5
        securitiesOfClientsLabel.frame.size.height = mainView.frame.height/15
        securitiesOfClientsLabel.text = "Securities of my clients"
        securitiesOfClientsLabel.frame.origin.x = 25
        securitiesOfClientsLabel.frame.origin.y = clientsScrollView.frame.origin.y + clientsScrollView.frame.height + 20
        securitiesOfClientsLabel.font = UIFont.boldSystemFont(ofSize: 25)
        securitiesOfClientsLabel.adjustsFontSizeToFitWidth = true
        
        infoButton.frame.size.width = self.view.frame.width/6
        infoButton.frame.size.height = infoButton.frame.width
        infoButton.frame.origin.y = 25
        infoButton.frame.origin.x = self.view.frame.width - infoButton.frame.width - 15
        infoButton.setImage(UIImage(named: "unnamed.png"), for: .normal)
        infoButton.imageView?.contentMode = .scaleAspectFill
        
        helloLabel.frame.size.width = self.view.frame.width/3
        helloLabel.frame.size.height = infoButton.frame.height/2
        helloLabel.frame.origin.y = infoButton.frame.origin.y + infoButton.frame.height + 10
        helloLabel.frame.origin.x = 20
        helloLabel.textColor = .white
        helloLabel.text = "Hello!"
        helloLabel.font = UIFont.systemFont(ofSize: 22)
        
        managerNameLabel.frame.size.width = self.view.frame.width
        managerNameLabel.frame.size.height = infoButton.frame.height/2
        managerNameLabel.frame.origin.y = helloLabel.frame.origin.y + helloLabel.frame.height
        managerNameLabel.frame.origin.x = 20
        managerNameLabel.textColor = .white
        managerNameLabel.text = "John James"
        managerNameLabel.font = UIFont.boldSystemFont(ofSize: 28)
        
        securitiesTableView.frame.size.width = self.view.frame.width - 50
        securitiesTableView.frame.size.height = clientsScrollView.frame.height + 10
        securitiesTableView.frame.origin.x = 25
        securitiesTableView.frame.origin.y = securitiesOfClientsLabel.frame.origin.y + securitiesOfClientsLabel.frame.height + 10
        securitiesTableView.backgroundColor = .clear
        securitiesTableView.delegate = self
        securitiesTableView.dataSource = self
        securitiesTableView.register(SecuritiesTableViewCell.self, forCellReuseIdentifier: "security")
        securitiesTableView.layer.cornerRadius = 10
        securitiesTableView.clipsToBounds = true
        
        managerImage.frame.size.width = infoButton.frame.width/1.3
        managerImage.frame.size.height = infoButton.frame.height/1.3
        managerImage.frame.origin.x = 20
        managerImage.frame.origin.y = 35
        managerImage.setImage(UIImage(named: "89762769_223800988749873_7596640348722429952_n.jpg"), for: .normal)
        managerImage.imageView?.contentMode = .scaleAspectFill
        managerImage.layer.cornerRadius = managerImage.frame.width/2
        managerImage.clipsToBounds = true
        managerImage.layer.borderWidth = 1
        managerImage.layer.borderColor = UIColor.white.cgColor
        managerImage.addTarget(self, action: #selector(managerDetails), for: .touchUpInside)
        
        logoTitle.frame.size.height = infoButton.frame.height
        logoTitle.frame.size.width = self.view.frame.width/2
        logoTitle.frame.origin.y = 30
        logoTitle.center.x = self.view.center.x
        logoTitle.textColor = .white
        logoTitle.text = "AegiS"
        logoTitle.textAlignment = .center
        logoTitle.font = UIFont(name: "BodoniSvtyTwoITCTT-Bold", size: 55)
        
        dotsLabel.frame.size.height = 40
        dotsLabel.frame.size.width = mainView.frame.width/3
        dotsLabel.frame.origin.y = clientsScrollView.frame.origin.y + clientsScrollView.frame.height - 10
        dotsLabel.center.x = mainView.center.x
        dotsLabel.numberOfPages = Int(round(Double(clientsScrollView.contentSize.width/clientsScrollView.frame.width)))
        dotsLabel.currentPageIndicatorTintColor = .darkGray
        dotsLabel.pageIndicatorTintColor = .lightGray
        
        clientsSeeAll.titleLabel?.textAlignment = .center
        clientsSeeAll.setTitleColor(.systemBlue, for: .normal)
        clientsSeeAll.setTitle("SEE ALL", for: .normal)
        clientsSeeAll.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        clientsSeeAll.sizeToFit()
        clientsSeeAll.frame.origin.x = mainView.frame.width - 25 - clientsSeeAll.frame.width
        clientsSeeAll.center.y = myClientsLabel.center.y + 2
        clientsSeeAll.addTarget(self, action: #selector(goToCients), for: .touchUpInside)
        
        let underlineView1 = UIView()
        underlineView1.frame.size.width = clientsSeeAll.frame.width
        underlineView1.frame.size.height = 1.0
        underlineView1.backgroundColor = .systemBlue
        underlineView1.frame.origin.y = clientsSeeAll.frame.height - 5
        clientsSeeAll.addSubview(underlineView1)
        
        securitiesSeeAll.titleLabel?.textAlignment = .center
        securitiesSeeAll.setTitleColor(.systemBlue, for: .normal)
        securitiesSeeAll.setTitle("SEE ALL", for: .normal)
        securitiesSeeAll.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15.0)
        securitiesSeeAll.sizeToFit()
        securitiesSeeAll.frame.origin.x = mainView.frame.width - 25 - securitiesSeeAll.frame.width
        securitiesSeeAll.center.y = securitiesOfClientsLabel.center.y + 2
        securitiesSeeAll.addTarget(self, action: #selector(goToSecurities), for: .touchUpInside)
        
        let underlineView2 = UIView()
        underlineView2.frame.size.width = securitiesSeeAll.frame.width
        underlineView2.frame.size.height = 1.0
        underlineView2.backgroundColor = .systemBlue
        underlineView2.frame.origin.y = securitiesSeeAll.frame.height - 5
        securitiesSeeAll.addSubview(underlineView2)
        
        line1.frame.size.width = mainView.frame.width/2.5
        line1.frame.size.height = 2
        line1.frame.origin.y = mainView.frame.origin.y - 35
        line1.frame.origin.x = 0
        line1.backgroundColor = .white
        
        line2.frame.size.width = mainView.frame.width/2.5
        line2.frame.size.height = 2
        line2.frame.origin.y = mainView.frame.origin.y - 35
        line2.frame.origin.x = self.view.frame.width - line2.frame.width
        line2.backgroundColor = .white
        
        self.view.addSubview(backgroundImage)
        self.view.addSubview(mainView)
        self.view.addSubview(infoButton)
        self.view.addSubview(helloLabel)
        self.view.addSubview(managerNameLabel)
        self.view.addSubview(managerImage)
        self.view.addSubview(logoTitle)
        self.view.addSubview(line1)
        self.view.addSubview(line2)
        mainView.addSubview(myClientsLabel)
        mainView.addSubview(clientsScrollView)
        mainView.addSubview(securitiesOfClientsLabel)
        mainView.addSubview(securitiesTableView)
        mainView.addSubview(dotsLabel)
        mainView.addSubview(clientsSeeAll)
        mainView.addSubview(securitiesSeeAll)
        
        fetchClients()
    }
    
    @objc func goToSecurities(){
        (self.parent as! MainTabBarViewController).selectedIndex = 0
    }
    
    @objc func goToCients(){
        (self.parent as! MainTabBarViewController).selectedIndex = 2
    }
    
    @objc func managerDetails() {
        
        if mainView.isHidden == false {
            managerView.frame.size.width = mainView.frame.width 
            managerView.frame.size.height = mainView.frame.height
            managerView.backgroundColor = .red
            managerView.frame.origin.y = self.view.frame.height
            managerView.isHidden = true
            managerView.clipsToBounds = true
            managerView.layer.cornerRadius = 40
            managerView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
            managerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            managerView.alpha = 0
            self.view.addSubview(managerView)
            
            managerDetailsTitle.frame.size.width = myClientsLabel.frame.width*1.5
            managerDetailsTitle.frame.size.height = myClientsLabel.frame.height
            managerDetailsTitle.frame.origin.x = myClientsLabel.frame.origin.x
            managerDetailsTitle.frame.origin.y = myClientsLabel.frame.origin.y
            managerDetailsTitle.font = UIFont.boldSystemFont(ofSize: 25)
            managerDetailsTitle.text = "My details"
            managerView.addSubview(managerDetailsTitle)
            
            doneButton.titleLabel?.textAlignment = .center
            doneButton.setTitleColor(.systemBlue, for: .normal)
            doneButton.setTitle("DONE", for: .normal)
            doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            doneButton.sizeToFit()
            doneButton.frame.origin.x = managerView.frame.width - 25 - doneButton.frame.width
            doneButton.center.y = managerDetailsTitle.center.y
            doneButton.addTarget(self, action: #selector(closeManagerDetails), for: .touchUpInside)
            managerView.addSubview(doneButton)
            
            managerDetailsImage.frame.size.width = managerView.frame.width/2.5
            managerDetailsImage.frame.size.height = managerDetailsImage.frame.width
            managerDetailsImage.frame.origin.x = managerView.frame.origin.x  + 20
            managerDetailsImage.frame.origin.y = managerDetailsTitle.frame.origin.y + managerDetailsTitle.frame.height + 20
            managerDetailsImage.contentMode = .scaleAspectFill
            managerDetailsImage.clipsToBounds = true
            managerDetailsImage.layer.cornerRadius = 10
            managerView.addSubview(managerDetailsImage)
            
            clientsTitle.frame.size.width = managerView.frame.width/2
            clientsTitle.frame.size.height = myClientsLabel.frame.height
            clientsTitle.frame.origin.x = myClientsLabel.frame.origin.x
            clientsTitle.frame.origin.y = managerDetailsImage.frame.origin.y + managerDetailsImage.frame.height + 20
            clientsTitle.textColor = .gray
            clientsTitle.text = "Clients"
            managerView.addSubview(clientsTitle)
            
            numberOfClientsLabel.frame.size.width = managerView.frame.width/2
            numberOfClientsLabel.frame.size.height = myClientsLabel.frame.height
            numberOfClientsLabel.frame.origin.x = myClientsLabel.frame.origin.x
            numberOfClientsLabel.frame.origin.y = clientsTitle.frame.origin.y + clientsTitle.frame.height - 5
            numberOfClientsLabel.textColor = .black
            numberOfClientsLabel.font = UIFont.boldSystemFont(ofSize: 25)
            numberOfClientsLabel.text = "\(clients.count)"
            managerView.addSubview(numberOfClientsLabel)
            
            emailTitle.frame.size.width = managerView.frame.width/2
            emailTitle.frame.size.height = myClientsLabel.frame.height
            emailTitle.frame.origin.x = myClientsLabel.frame.origin.x
            emailTitle.frame.origin.y = numberOfClientsLabel.frame.origin.y + numberOfClientsLabel.frame.height
            emailTitle.textColor = .gray
            emailTitle.text = "Email"
            managerView.addSubview(emailTitle)
            
            emailTextField.frame.size.width = managerView.frame.width*2/3
            emailTextField.frame.size.height = myClientsLabel.frame.height
            emailTextField.frame.origin.x = myClientsLabel.frame.origin.x
            emailTextField.frame.origin.y = emailTitle.frame.origin.y + emailTitle.frame.height
            emailTextField.text = ""
            
            let ref = Database.database().reference()
            
            ref.child("managers").child("\(Auth.auth().currentUser!.uid)").observeSingleEvent(of: .value, with: {(snapshot) in
                let fetchedData = snapshot.value as! [String: AnyObject]
                
                self.emailTextField.text = fetchedData["email"] as? String
            })
            
            emailTextField.backgroundColor = UIColor.white
            emailTextField.clipsToBounds = true
            emailTextField.layer.cornerRadius = 10
            emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: emailTextField.frame.height))
            emailTextField.leftViewMode = .always
            emailTextField.isEnabled = false
            managerView.addSubview(emailTextField)
            
            editEmailButton.titleLabel?.textAlignment = .center
            editEmailButton.setTitleColor(.systemBlue, for: .normal)
            editEmailButton.setTitle("EDIT", for: .normal)
            editEmailButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            editEmailButton.sizeToFit()
            editEmailButton.frame.origin.x = managerView.frame.width - 25 - editEmailButton.frame.width
            editEmailButton.center.y = emailTextField.center.y
            editEmailButton.addTarget(self, action: #selector(editEmail), for: .touchUpInside)
            managerView.addSubview(editEmailButton)
            
            let underlineView1 = UIView()
            underlineView1.frame.size.width = editEmailButton.frame.width
            underlineView1.frame.size.height = 1.0
            underlineView1.backgroundColor = .systemBlue
            underlineView1.frame.origin.y = editEmailButton.frame.height - 5
            editEmailButton.addSubview(underlineView1)
            
            passwordTitle.frame.size.width = managerView.frame.width/2
            passwordTitle.frame.size.height = myClientsLabel.frame.height
            passwordTitle.frame.origin.x = myClientsLabel.frame.origin.x
            passwordTitle.frame.origin.y = emailTextField.frame.origin.y + emailTextField.frame.height + 10
            passwordTitle.textColor = .gray
            passwordTitle.text = "Password"
            managerView.addSubview(passwordTitle)
            
            passwordButton.frame.size.width = emailTextField.frame.width
            passwordButton.frame.size.height = emailTextField.frame.height
            passwordButton.frame.origin.x = myClientsLabel.frame.origin.x
            passwordButton.frame.origin.y = passwordTitle.frame.origin.y + passwordTitle.frame.height
            
            if passwordButton.layer.sublayers?.count == nil {
                passwordButton.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 5, height: 5), opacity: 1.0, shadowRadius: 3, cornerRadius: 10, corners: .allCorners, fillColor: .white)

            }
            passwordButton.setTitle("Send email to change password", for: .normal)
            passwordButton.titleLabel?.adjustsFontSizeToFitWidth = true
            passwordButton.setTitleColor(.black, for: .normal)
            passwordButton.addTarget(self, action: #selector(resetPassword), for: .touchUpInside)
            managerView.addSubview(passwordButton)
            
            managerLine1.frame.size.width = managerView.frame.width*2/3
            managerLine1.frame.size.height = 2
            managerLine1.frame.origin.y = clientsTitle.frame.origin.y
            managerLine1.frame.origin.x = myClientsLabel.frame.origin.x
            managerLine1.backgroundColor = .lightGray
            managerView.addSubview(managerLine1)
            
            managerLine2.frame.size.width = managerView.frame.width*2/3
            managerLine2.frame.size.height = 2
            managerLine2.frame.origin.y = numberOfClientsLabel.frame.origin.y + numberOfClientsLabel.frame.height
            managerLine2.frame.origin.x = myClientsLabel.frame.origin.x
            managerLine2.backgroundColor = .lightGray
            managerView.addSubview(managerLine2)
            
            managerLine3.frame.size.width = managerView.frame.width*2/3
            managerLine3.frame.size.height = 2
            managerLine3.frame.origin.y = emailTextField.frame.origin.y + emailTextField.frame.height + 12.5
            managerLine3.frame.origin.x = myClientsLabel.frame.origin.x
            managerLine3.backgroundColor = .lightGray
            managerView.addSubview(managerLine3)
            
            UIView.animate(withDuration: 0.5, animations: {
                
                self.mainView.frame.origin.y = self.view.frame.height
                self.mainView.alpha = 0
                
            }, completion: {(value) in
                
                self.mainView.isHidden = true
                UIView.animate(withDuration: 0.5, animations: {
                    self.managerView.isHidden = false
                    self.managerView.alpha = 1.0
                    self.managerView.frame.origin.y = self.view.frame.height - self.managerView.frame.height
                }, completion: {(value) in
                    
                })
            })
        }
    }
    
    @objc func closeManagerDetails(){
        UIView.animate(withDuration: 0.5, animations: {
            
            self.managerView.frame.origin.y = self.view.frame.height
            self.managerView.alpha = 0
            
        }, completion: {(value) in
            
            self.managerView.isHidden = true
            for view in self.managerView.subviews {
                view.removeFromSuperview()
            }
            UIView.animate(withDuration: 0.5, animations: {
                self.mainView.isHidden = false
                self.mainView.alpha = 1.0
                self.mainView.frame.origin.y = self.view.frame.height - self.managerView.frame.height
            }, completion: {(value) in
                
            })
        })
    }
    
    @objc func resetPassword() {
        let alertView = UIAlertController(title: "Reset Password", message: "Enter your email", preferredStyle: .alert)
        
        alertView.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Email"
        })
        
        alertView.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(action) in
            
        }))
        
        alertView.addAction(UIAlertAction(title: "Send email", style: .default, handler: {(action) in
            let email = alertView.textFields![0].text!
            
            print(email)
            
            Auth.auth().sendPasswordReset(withEmail: email, completion: {error in
                if error != nil {
                    print(error!)
                }
                else {
                    
                }
            })
        }))
        
        self.present(alertView, animated: true, completion: nil)
    }
    
    @objc func editEmail(sender: UIButton) {
        if sender.titleLabel?.text == "SAVE" {
            sender.setTitle("EDIT", for: .normal)
            editEmailButton.sizeToFit()
            editEmailButton.frame.origin.x = managerView.frame.width - 25 - editEmailButton.frame.width
            editEmailButton.center.y = emailTextField.center.y
            emailTextField.isEnabled = false
            emailTextField.resignFirstResponder()
        }
        else {
            sender.setTitle("SAVE", for: .normal)
            editEmailButton.sizeToFit()
            editEmailButton.frame.origin.x = managerView.frame.width - 25 - editEmailButton.frame.width
            editEmailButton.center.y = emailTextField.center.y
            
            emailTextField.isEnabled = true
            emailTextField.becomeFirstResponder()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "security", for: indexPath) as! SecuritiesTableViewCell
        cell.selectionStyle = .none
        cell.title.frame.size.height = cell.frame.height
        cell.title.frame.size.width = cell.frame.width*3/5
        cell.title.frame.origin.x = 15
        cell.title.text = securities[indexPath.row]["Short description"] as? String
        cell.title.font = UIFont.boldSystemFont(ofSize: 15)
        
        cell.arrow.frame.size.height = cell.frame.height
        cell.arrow.frame.size.width = 30
        cell.arrow.frame.origin.x = cell.frame.width - 40
        cell.arrow.image = UIImage(systemName: "arrow.up")
        cell.arrow.tintColor = .red
        cell.arrow.contentMode = .scaleAspectFit
        
        if (securities[indexPath.row]["Price 5"] as! Int) >= (securities[indexPath.row]["Price 4"] as! Int) { // price going up
            cell.arrow.tintColor = .green
            cell.arrow.image = UIImage(systemName: "arrow.up")
        }
        else {
            cell.arrow.tintColor = .red
            cell.arrow.image = UIImage(systemName: "arrow.down")
        }
        
        cell.price.frame.size.height = cell.frame.height/3
        cell.price.frame.size.width = cell.frame.width - cell.arrow.frame.width - 10 - cell.title.frame.width - 15
        cell.price.frame.origin.x = cell.title.frame.origin.x + cell.title.frame.width
        cell.price.frame.origin.y = 15
        cell.price.textAlignment = .center
        cell.price.text = "£\((securities[indexPath.row]["Price 5"] as! Int))"
        cell.price.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.percentage.frame.size = cell.price.frame.size
        cell.percentage.frame.origin.x = cell.price.frame.origin.x
        cell.percentage.frame.origin.y = cell.price.frame.origin.y + cell.price.frame.height
        cell.percentage.textColor = .red
        cell.percentage.textAlignment = .center
        
        let percentageChange = ((securities[indexPath.row]["Price 5"] as! Double) - (securities[indexPath.row]["Price 4"] as! Double))/(securities[indexPath.row]["Price 4"] as! Double)*100
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
        return securities.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let securityVC = SecurityViewController()
        securityVC.security = securities[indexPath.row]
        securityVC.modalPresentationStyle = .fullScreen
        self.present(securityVC, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x/scrollView.frame.width
        dotsLabel.currentPage = Int(round(pageNumber))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupClientViews() {
        
        for client in 0..<(clients.count) {
            let cview = clientView()
            
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didSelectClient(tap:)))
            tap.accessibilityLabel = "\(client)"
            
            cview.addGestureRecognizer(tap)
            
            let imageName = clients[client]["Image"] as! String
            // Create a reference to the file you want to download
            let imageRef = Storage.storage().reference().child("images/\(imageName)")

            cview.isUserInteractionEnabled = false
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            imageRef.getData(maxSize: 1 * 1256 * 1256) { data, error in
              if let error = error {
                // Uh-oh, an error occurred!
                print("Error")
                print(error)
              } else {
                // Data for thee image is returned
                cview.imageView.image = UIImage(data: data!)
                self.clients[client]["Image"] = UIImage(data: data!)
                cview.isUserInteractionEnabled = true
              }
            }
            cview.imageView.contentMode = .scaleAspectFill
            cview.imageView.clipsToBounds = true
            cview.frame.size.height = clientsScrollView.frame.height - 15
            cview.frame.size.width = clientsScrollView.frame.width/2.75
            cview.nameLabel.frame.origin.x = 5
            cview.nameLabel.center.y = cview.frame.height*3.6/5
            cview.nameLabel.text = "\((clients[client]["Name"] as! String) + " " + (clients[client]["Surname"] as! String))"
            cview.nameLabel.adjustsFontSizeToFitWidth = true
            cview.emailLabel.text = "\(clients[client]["Email"] as! String)"
            cview.emailLabel.adjustsFontSizeToFitWidth = true
            cview.emailLabel.frame.origin.x = 5
            cview.emailLabel.center.y = cview.frame.height*4.20/5
            cview.imageView.frame.origin.x = 20
            cview.imageView.center.y = cview.frame.height*0.5/5
            cview.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 10, height: 5), opacity: 1.0, shadowRadius: 3, cornerRadius: 10.0, corners: [.allCorners], fillColor: .white)
            clientViews.append(cview)
        }
        
        clientsScrollView.contentSize = CGSize(width: (clientsScrollView.frame.width/2.75+30)*CGFloat(clientViews.count), height: clientsScrollView.frame.height)
        
        for client in 0..<(clientViews.count) {
            clientViews[client].frame.origin.x = (clientsScrollView.frame.width/2.75)*CGFloat(client) + CGFloat(30*client)
            clientsScrollView.addSubview(clientViews[client])
        }
        
        dotsLabel.numberOfPages = Int(round(Double(clientsScrollView.contentSize.width/clientsScrollView.frame.width)))
    }
    
    @objc func didSelectClient(tap: UITapGestureRecognizer) {
        let index = Int(tap.accessibilityLabel! as String)!
        
        print("cell clicked")
        let clientVC = SingleClientViewController()
        clientVC.client = clients[index]
        clientVC.modalPresentationStyle = .fullScreen
        self.present(clientVC, animated: true, completion: nil)
    }
    
    func fetchClients() {
        let ref = Database.database().reference()
        
        ref.child("clients").observeSingleEvent(of: .value, with: {(snapshot) in
            let fetchedData = snapshot.value as! [AnyObject]
            for value in fetchedData {
                if value.value(forKey: "RM ID") as! Int == self.managerID {
                    self.clients.append(value as! [String : AnyObject])
                }
            }
            self.setupClientViews()
            self.fetchSecurities()
        })
    }
    
    func fetchSecurities() {
        var clientIDs = [Int]()
        for client in clients {
            clientIDs.append(client["Customer ID"] as! Int)
        }
        print("HERE")
        print(clientIDs)
        
        var portfolios = [String]()
        
        let ref = Database.database().reference()
        ref.child("portfolios").observeSingleEvent(of: .value, with: {(snapshot) in
            let fetchedData = snapshot.value as! [AnyObject]
            for value in fetchedData {
                if clientIDs.contains(value.value(forKey: "CUSTOMER ID") as! Int) {
                    portfolios.append(value.value(forKey: "PORTFOLIO ID") as! String)
                }
            }
            print("HERE1111")
            print(portfolios.count)
            print(portfolios)
            
            var fetchedSecuritiesIDs = [String]()
            ref.child("trades").observeSingleEvent(of: .value, with: {(snapshot) in
                let fetchedData = snapshot.value as! [AnyObject]
                for value in fetchedData {
                    if portfolios.contains(value.value(forKey: "Portfolio ID") as! String) {
                        if fetchedSecuritiesIDs.contains(value.value(forKey: "Security ID") as! String) == false {
                            fetchedSecuritiesIDs.append(value.value(forKey: "Security ID") as! String)
                        }
                    }
                }
                
                print("HERE2222222")
                print(fetchedSecuritiesIDs.count)
                
                ref.child("securities").observeSingleEvent(of: .value, with: {(snapshot) in
                    let fetchedData = snapshot.value as! [AnyObject]
                    for value in fetchedData {
                        if fetchedSecuritiesIDs.contains(value.value(forKey: "Security code") as! String) {
                            self.securities.append(value as! [String : AnyObject])
                        }
                    }
                    
                    print(self.securities.count)
                    self.securitiesTableView.reloadData()
                })
            })
        })
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
