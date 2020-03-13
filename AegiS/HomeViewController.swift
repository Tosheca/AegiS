//
//  HomeViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/10/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

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
    
    var securities = [String]()
    var securityPrices = [Double]()
    var securityPercentages = [Double]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //for disabling dark mode
        //self.overrideUserInterfaceStyle = .light
        self.edgesForExtendedLayout = []
        
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
        
        clientsScrollView.contentSize = CGSize(width: (clientsScrollView.frame.width/2.75+30)*CGFloat(clientViews.count), height: clientsScrollView.frame.height)
        
        for client in 0..<(clientViews.count) {
            clientViews[client].frame.origin.x = (clientsScrollView.frame.width/2.75)*CGFloat(client) + CGFloat(30*client)
            clientsScrollView.addSubview(clientViews[client])
        }
        
        securitiesOfClientsLabel.frame.size.width = mainView.frame.width/1.5
        securitiesOfClientsLabel.frame.size.height = mainView.frame.height/15
        securitiesOfClientsLabel.text = "Securities of my clients"
        securitiesOfClientsLabel.frame.origin.x = 25
        securitiesOfClientsLabel.frame.origin.y = clientsScrollView.frame.origin.y + clientsScrollView.frame.height + 20
        securitiesOfClientsLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        infoButton.frame.size.width = self.view.frame.width/5
        infoButton.frame.size.height = infoButton.frame.width
        infoButton.frame.origin.y = 35
        infoButton.frame.origin.x = self.view.frame.width - infoButton.frame.width - 15
        //infoButton.backgroundColor = .yellow
        infoButton.setImage(UIImage(named: "unnamed.png"), for: .normal)
        infoButton.imageView?.contentMode = .scaleAspectFill
        
        helloLabel.frame.size.width = self.view.frame.width/3
        helloLabel.frame.size.height = infoButton.frame.height/2
        helloLabel.frame.origin.y = infoButton.frame.origin.y + infoButton.frame.height + 20
        helloLabel.frame.origin.x = 30
        helloLabel.textColor = .white
        helloLabel.text = "Hello!"
        helloLabel.font = UIFont.systemFont(ofSize: 22)
        
        managerNameLabel.frame.size.width = self.view.frame.width
        managerNameLabel.frame.size.height = infoButton.frame.height/2
        managerNameLabel.frame.origin.y = helloLabel.frame.origin.y + helloLabel.frame.height
        managerNameLabel.frame.origin.x = 30
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
        
        managerImage.frame.size = infoButton.frame.size
        managerImage.frame.origin.x = 20
        managerImage.frame.origin.y = infoButton.frame.origin.y
        managerImage.setImage(UIImage(named: "89762769_223800988749873_7596640348722429952_n.jpg"), for: .normal)
        managerImage.imageView?.contentMode = .scaleAspectFill
        managerImage.layer.cornerRadius = managerImage.frame.width/2
        managerImage.clipsToBounds = true
        managerImage.layer.borderWidth = 1
        managerImage.layer.borderColor = UIColor.white.cgColor
        
        logoTitle.frame.size.height = infoButton.frame.height
        logoTitle.frame.size.width = self.view.frame.width/2
        logoTitle.frame.origin.y = infoButton.frame.origin.y
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
        
        self.view.addSubview(backgroundImage)
        self.view.addSubview(mainView)
        self.view.addSubview(infoButton)
        self.view.addSubview(helloLabel)
        self.view.addSubview(managerNameLabel)
        self.view.addSubview(managerImage)
        self.view.addSubview(logoTitle)
        mainView.addSubview(myClientsLabel)
        mainView.addSubview(clientsScrollView)
        mainView.addSubview(securitiesOfClientsLabel)
        mainView.addSubview(securitiesTableView)
        mainView.addSubview(dotsLabel)
        mainView.addSubview(clientsSeeAll)
        mainView.addSubview(securitiesSeeAll)
        
        securities = ["David Jones Ltd Shs AUD NPV", "Allied Dunbar North Am Gth A/c R", "Schroder Global Emer Mtks Acc Uts A", "Schroder Retail Global Emer Inc Uts", "Barnes & Noble Inc Shs USD NPV"]
        securityPrices = [1234.25, 5234.56, 2131.67, 3242.56, 3242.89]
        securityPercentages = [0.7, 2.7, 4.3, 7.8, 1.1]
    }
    
    @objc func goToSecurities(){
        (self.parent as! MainTabBarViewController).selectedIndex = 0
    }
    
    @objc func goToCients(){
        (self.parent as! MainTabBarViewController).selectedIndex = 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "security", for: indexPath) as! SecuritiesTableViewCell
        cell.title.frame.size.height = cell.frame.height
        cell.title.frame.size.width = cell.frame.width*3/5
        cell.title.frame.origin.x = 15
        cell.title.text = securities[indexPath.row]
        cell.title.font = UIFont.boldSystemFont(ofSize: 15)
        
        cell.arrow.frame.size.height = cell.frame.height
        cell.arrow.frame.size.width = 30
        cell.arrow.frame.origin.x = cell.frame.width - 40
        cell.arrow.image = UIImage(systemName: "arrow.up")
        cell.arrow.tintColor = .red
        cell.arrow.contentMode = .scaleAspectFit
        
        cell.price.frame.size.height = cell.frame.height/3
        cell.price.frame.size.width = cell.frame.width - cell.arrow.frame.width - 10 - cell.title.frame.width - 15
        cell.price.frame.origin.x = cell.title.frame.origin.x + cell.title.frame.width
        cell.price.frame.origin.y = 15
        cell.price.textAlignment = .center
        cell.price.text = "\(securityPrices[indexPath.row])"
        cell.price.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.percentage.frame.size = cell.price.frame.size
        cell.percentage.frame.origin.x = cell.price.frame.origin.x
        cell.percentage.frame.origin.y = cell.price.frame.origin.y + cell.price.frame.height
        cell.percentage.textColor = .red
        cell.percentage.textAlignment = .center
        cell.percentage.text = "-\(securityPercentages[indexPath.row])%"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
        var client1 = clientView()
        client1.imageView.image = UIImage(named: "89930680_198473048089654_6530749024859848704_n.jpg")
        client1.imageView.contentMode = .scaleAspectFill
        client1.imageView.clipsToBounds = true
        client1.frame.size.height = clientsScrollView.frame.height - 15
        client1.frame.size.width = clientsScrollView.frame.width/2.75
        client1.nameLabel.frame.origin.x = 5
        client1.nameLabel.center.y = client1.frame.height*3.6/5
        client1.nameLabel.text = "Boris Simple"
        client1.emailLabel.frame.origin.x = 5
        client1.emailLabel.center.y = client1.frame.height*4.20/5
        client1.emailLabel.text = "boris@gmail.com"
        client1.imageView.frame.origin.x = 20
        client1.imageView.center.y = client1.frame.height*0.5/5
        client1.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 10, height: 5), opacity: 1.0, shadowRadius: 3, cornerRadius: 10.0, corners: [.allCorners], fillColor: .white)
        
        var client2 = clientView()
        client2.imageView.image = UIImage(named: "89762769_223800988749873_7596640348722429952_n.jpg")
        client2.imageView.contentMode = .scaleAspectFill
        client2.imageView.clipsToBounds = true
        client2.frame.size.height = clientsScrollView.frame.height - 15
        client2.frame.size.width = clientsScrollView.frame.width/2.75
        client2.nameLabel.frame.origin.x = 5
        client2.nameLabel.center.y = client2.frame.height*3.6/5
        client2.nameLabel.text = "Mona Simple"
        client2.emailLabel.frame.origin.x = 5
        client2.emailLabel.center.y = client2.frame.height*4.20/5
        client2.emailLabel.text = "boris@gmail.com"
        client2.imageView.frame.origin.x = 20
        client2.imageView.center.y = client2.frame.height*0.5/5
        client2.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 10, height: 5), opacity: 1.0, shadowRadius: 3, cornerRadius: 10.0, corners: [.allCorners], fillColor: .white)
        
        var client3 = clientView()
        client3.imageView.image = UIImage(named: "89854406_814414002390551_1132090573918830592_n.jpg")
        client3.imageView.contentMode = .scaleAspectFill
        client3.imageView.clipsToBounds = true
        client3.frame.size.height = clientsScrollView.frame.height - 15
        client3.frame.size.width = clientsScrollView.frame.width/2.75
        client3.nameLabel.frame.origin.x = 5
        client3.nameLabel.center.y = client3.frame.height*3.6/5
        client3.nameLabel.text = "Zhilber Baev"
        client3.emailLabel.frame.origin.x = 5
        client3.emailLabel.center.y = client3.frame.height*4.20/5
        client3.emailLabel.text = "boris@gmail.com"
        client3.imageView.frame.origin.x = 20
        client3.imageView.center.y = client3.frame.height*0.5/5
        client3.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 10, height: 5), opacity: 1.0, shadowRadius: 3, cornerRadius: 10.0, corners: [.allCorners], fillColor: .white)
        
        var client4 = clientView()
        
        client4.frame.size.height = clientsScrollView.frame.height - 15
        client4.frame.size.width = clientsScrollView.frame.width/2.75
        client4.nameLabel.frame.origin.x = 5
        client4.nameLabel.center.y = client4.frame.height*3.6/5
        client4.nameLabel.text = "Teodor Pavlov"
        client4.emailLabel.frame.origin.x = 5
        client4.emailLabel.center.y = client4.frame.height*4.20/5
        client4.emailLabel.text = "boris@gmail.com"
        client4.imageView.frame.origin.x = 20
        client4.imageView.center.y = client4.frame.height*0.5/5
        client4.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 10, height: 5), opacity: 1.0, shadowRadius: 3, cornerRadius: 10.0, corners: [.allCorners], fillColor: .white)
        
        clientViews.append(client1)
        clientViews.append(client2)
        clientViews.append(client3)
        clientViews.append(client4)
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
