//
//  ClientsViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/10/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

class ClientsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var backgroundImage = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var backgroundImage1 = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var topBackgroundView = UIView()
    var bottomBackgroundView = UIView()
    var titleLabel = UILabel()
    var totalClientsLabel = UILabel()
    var clientsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var searchBar = UISearchBar()
    
    var clientNames = [String]()
    var clientImages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = []
        
        self.view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        
        backgroundImage.frame.size.width = self.view.frame.size.width
        backgroundImage.frame.size.height = self.view.frame.size.height
        backgroundImage.contentMode = .scaleAspectFill
        
        backgroundImage1.frame.size.width = self.view.frame.size.width
        backgroundImage1.frame.size.height = self.view.frame.size.height
        backgroundImage1.contentMode = .scaleAspectFill
        backgroundImage1.frame.origin.y = -(self.view.frame.height - 83)
        
        topBackgroundView.frame.size.width = self.view.frame.size.width
        topBackgroundView.frame.size.height = self.view.frame.size.height*2.5/7
        topBackgroundView.clipsToBounds = true
        topBackgroundView.layer.cornerRadius = 40
        topBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        bottomBackgroundView.frame.size.width = self.view.frame.size.width
        bottomBackgroundView.frame.size.height = 83
        bottomBackgroundView.clipsToBounds = true
        bottomBackgroundView.frame.origin.y = self.view.frame.height - 83
        bottomBackgroundView.backgroundColor = .red
        
        titleLabel.frame.size.width = self.view.frame.width
        titleLabel.frame.size.height = self.view.frame.height/15
        titleLabel.text = "CLIENTS"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        //titleLabel.backgroundColor = .green
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.frame.origin.y = 40
        
        clientsCollectionView.frame.size.width = self.view.frame.width - 50
        clientsCollectionView.frame.size.height = self.view.frame.size.height*4.5/7
        clientsCollectionView.frame.origin.x = 25
        clientsCollectionView.frame.origin.y = self.view.frame.height - 83 - clientsCollectionView.frame.height - 5
        clientsCollectionView.backgroundColor = .clear
        clientsCollectionView.delegate = self
        clientsCollectionView.dataSource = self
        clientsCollectionView.register(ClientsCollectionViewCell.self, forCellWithReuseIdentifier: "client")
        clientsCollectionView.showsVerticalScrollIndicator = false
        
        totalClientsLabel.frame.size.width = self.view.frame.width
        totalClientsLabel.frame.size.height = self.view.frame.height/20
        totalClientsLabel.text = "Total clients: 4"
        totalClientsLabel.textColor = .lightText
        totalClientsLabel.textAlignment = .center
        totalClientsLabel.font = UIFont.boldSystemFont(ofSize: 15)
        totalClientsLabel.frame.origin.y = titleLabel.frame.origin.y + totalClientsLabel.frame.height - 10
        
        searchBar.frame.size.width = clientsCollectionView.frame.width
        searchBar.frame.size.height = titleLabel.frame.height
        searchBar.frame.origin.y = totalClientsLabel.frame.origin.y + totalClientsLabel.frame.height + 10
        searchBar.frame.origin.x = 25
        searchBar.delegate = self
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        searchBar.tintColor = .white
        searchBar.placeholder = "Search"
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField

        textFieldInsideSearchBar?.textColor = .white
        
        let glassIconView = textFieldInsideSearchBar!.leftView as? UIImageView

        //Magnifying glass
        glassIconView!.image = glassIconView!.image?.withRenderingMode(.alwaysTemplate)
        glassIconView!.tintColor = .white
        
        clientNames = ["","Boris Simple", "Mona Simple", "Zhilber Baev", "Teodor Pavlov"]
        clientImages = ["", "89762769_223800988749873_7596640348722429952_n.jpg", "89854406_814414002390551_1132090573918830592_n.jpg", "89930680_198473048089654_6530749024859848704_n.jpg", ""]
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
        
        self.view.addSubview(topBackgroundView)
        topBackgroundView.addSubview(backgroundImage)
        self.view.addSubview(bottomBackgroundView)
        bottomBackgroundView.addSubview(backgroundImage1)
        self.view.addSubview(titleLabel)
        self.view.addSubview(clientsCollectionView)
        self.view.addSubview(totalClientsLabel)
        self.view.addSubview(searchBar)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            searchBar.showsCancelButton = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = ""
        searchBar.showsCancelButton = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 25)/2, height: collectionView.frame.width/1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "client", for: indexPath) as! ClientsCollectionViewCell
        //cell.backgroundColor = .green
        
        cell.backgroundColor = .clear
        cell.bcView.frame.size.width = cell.frame.width - 20
        cell.bcView.frame.size.height = cell.frame.height - 25
        cell.bcView.frame.origin.x = 10
        
        print(cell.bcView.layer.sublayers?.count)
        if cell.bcView.layer.sublayers?.count == 3 {
            cell.bcView.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 7.5), opacity: 0.8, shadowRadius: 5, cornerRadius: 10.0, corners: [.allCorners], fillColor: .white)
        }
        
        cell.bcView.addSubview(cell.nameLabel)
        cell.bcView.addSubview(cell.emailLabel)
        cell.bcView.addSubview(cell.imageView)
        
        cell.nameLabel.frame.size.width = cell.bcView.frame.size.width - 10
        cell.nameLabel.frame.size.height = cell.bcView.frame.height / 7
        //cell.nameLabel.backgroundColor = .red
        cell.nameLabel.textAlignment = .center
        cell.nameLabel.font = UIFont.systemFont(ofSize: 20)
        
        cell.emailLabel.frame.size.width = cell.bcView.frame.size.width - 10
        cell.emailLabel.frame.size.height = cell.bcView.frame.height / 7
        //cell.emailLabel.backgroundColor = .yellow
        cell.emailLabel.textAlignment = .center
        cell.emailLabel.font = UIFont.systemFont(ofSize: 15)
        cell.emailLabel.textColor = .gray
        
        cell.imageView.frame.size.width = cell.bcView.frame.size.width - 40
        cell.imageView.frame.size.height = cell.imageView.frame.width
        //cell.imageView.backgroundColor = .green
        
        cell.imageView.image = UIImage(named: "\(clientImages[indexPath.row])")
        cell.imageView.contentMode = .scaleAspectFill
        cell.imageView.clipsToBounds = true
        
        cell.nameLabel.frame.origin.x = 5
        cell.nameLabel.center.y = cell.bcView.frame.height*3.6/5
        cell.nameLabel.text = "\(clientNames[indexPath.row])"
        cell.emailLabel.frame.origin.x = 5
        cell.emailLabel.center.y = cell.bcView.frame.height*4.20/5
        cell.emailLabel.text = "sample@gmail.com"
        cell.imageView.frame.origin.x = 20
        cell.imageView.center.y = cell.bcView.frame.height*1.5/5
        
        if indexPath.row == 0 {
            cell.imageView.image = UIImage(systemName: "plus.circle")
            cell.imageView.tintColor = .gray
            cell.imageView.center.y = cell.bcView.frame.height*2/5
            cell.emailLabel.isHidden = true
            cell.nameLabel.text = "Add client"
            cell.nameLabel.center.y = cell.bcView.frame.height*4/5
            cell.imageView.frame.size.width = cell.bcView.frame.size.width - 50
            cell.imageView.frame.size.height = cell.imageView.frame.width
            cell.imageView.frame.origin.x = 25
        }
            
        return cell
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
