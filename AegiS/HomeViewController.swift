//
//  HomeViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/10/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    var mainView = UIView()
    var myClientsLabel = UILabel()
    var clientsScrollView = UIScrollView()
    var clientViews = [UIView]()
    var securitiesOfCLientsLabel = UILabel()
    var backgroundImage = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var infoButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.edgesForExtendedLayout = []
        
        self.view.backgroundColor = UIColor(red: 10/255, green: 22/255, blue: 46/255, alpha: 1.0)
        
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
        
        clientsScrollView.frame.size.width = mainView.frame.width - 25
        clientsScrollView.frame.size.height = mainView.frame.height/3 + 15
        clientsScrollView.frame.origin.x = 25
        clientsScrollView.frame.origin.y = 30 + myClientsLabel.frame.height + 20
        clientsScrollView.backgroundColor = .clear
        
        setupClientViews()
        
        clientsScrollView.contentSize = CGSize(width: (clientsScrollView.frame.width/2.75+30)*CGFloat(clientViews.count), height: clientsScrollView.frame.height)
        
        for client in 0..<(clientViews.count) {
            clientViews[client].frame.origin.x = (clientsScrollView.frame.width/2.75)*CGFloat(client) + CGFloat(30*client)
            clientsScrollView.addSubview(clientViews[client])
        }
        
        securitiesOfCLientsLabel.frame.size.width = mainView.frame.width/1.5
        securitiesOfCLientsLabel.frame.size.height = mainView.frame.height/15
        securitiesOfCLientsLabel.text = "Securities of my clients"
        securitiesOfCLientsLabel.frame.origin.x = 25
        securitiesOfCLientsLabel.frame.origin.y = clientsScrollView.frame.origin.y + clientsScrollView.frame.height + 20
        securitiesOfCLientsLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        infoButton.frame.size.width = self.view.frame.width/6
        infoButton.frame.size.height = infoButton.frame.width
        infoButton.frame.origin.y = 40
        infoButton.frame.origin.x = self.view.frame.width - infoButton.frame.width - 20
        //infoButton.backgroundColor = .yellow
        infoButton.setImage(UIImage(named: "unnamed.png"), for: .normal)
        infoButton.imageView?.contentMode = .scaleAspectFill
        
        self.view.addSubview(backgroundImage)
        self.view.addSubview(mainView)
        self.view.addSubview(infoButton)
        mainView.addSubview(myClientsLabel)
        mainView.addSubview(clientsScrollView)
        mainView.addSubview(securitiesOfCLientsLabel)
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
