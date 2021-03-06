//
//  ClientsViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/10/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ClientsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var backgroundImage = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var backgroundImage1 = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var topBackgroundView = UIView()
    var bottomBackgroundView = UIView()
    var titleLabel = UILabel()
    var totalClientsLabel = UILabel()
    var clientsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var searchBar = UISearchBar()
    
    var isSearching = false
    
    var clientNames = [String]()
    var clientImages = [String]()
    
    var clients = [[String: AnyObject]]()
    var searchClients = [[String: AnyObject]]()
    
    var managerID = Int()
    
    ///3478
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.overrideUserInterfaceStyle = .light
        self.edgesForExtendedLayout = []
        
        self.view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        
        managerID = UserDefaults.standard.value(forKey: "rmID") as! Int
        print("Manager ID: \(managerID)")
        
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
        clientsCollectionView.allowsSelection = true
        clientsCollectionView.isUserInteractionEnabled = true
        clientsCollectionView.allowsMultipleSelection = true
        
        totalClientsLabel.frame.size.width = self.view.frame.width
        totalClientsLabel.frame.size.height = self.view.frame.height/20
        totalClientsLabel.text = "Total clients: 0"
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
        
        //self.view.addGestureRecognizer(tap)
        
        self.view.addSubview(topBackgroundView)
        topBackgroundView.addSubview(backgroundImage)
        self.view.addSubview(bottomBackgroundView)
        bottomBackgroundView.addSubview(backgroundImage1)
        self.view.addSubview(clientsCollectionView)
        self.view.addSubview(searchBar)
        self.view.addSubview(titleLabel)
        self.view.addSubview(totalClientsLabel)

        fetchClients()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            searchBar.showsCancelButton = true
            self.isSearching = true
            searchClients = clients.filter({(($0["Name"] as! String)+" "+($0["Surname"] as! String)).lowercased().contains(searchText.lowercased())})
            self.clientsCollectionView.reloadData()
        }
        else {
            self.isSearching = false
            self.clientsCollectionView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = ""
        searchBar.showsCancelButton = false
        isSearching = false
        clientsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 25)/2, height: collectionView.frame.width/1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearching {
            return searchClients.count + 1
        }
        else {
            return clients.count + 1
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "client", for: indexPath) as! ClientsCollectionViewCell
        //cell.backgroundColor = .green
        cell.backgroundColor = .clear
        cell.bcView.frame.size.width = cell.frame.width - 20
        cell.bcView.frame.size.height = cell.frame.height - 25
        cell.bcView.frame.origin.x = 10
        
        if cell.bcView.layer.sublayers?.count == 3 {
            cell.bcView.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 7.5), opacity: 0.8, shadowRadius: 5, cornerRadius: 10.0, corners: [.allCorners], fillColor: .white)
        }
        
        cell.bcView.addSubview(cell.nameLabel)
        cell.bcView.addSubview(cell.emailLabel)
        cell.bcView.addSubview(cell.imageView)
        
        cell.nameLabel.frame.size.width = cell.bcView.frame.size.width - 10
        cell.nameLabel.frame.size.height = cell.bcView.frame.height / 4
        //cell.nameLabel.backgroundColor = .red
        cell.nameLabel.textAlignment = .center
        cell.nameLabel.font = UIFont.systemFont(ofSize: 20)
        cell.nameLabel.numberOfLines = 2
        cell.nameLabel.lineBreakMode = .byWordWrapping
        
        cell.emailLabel.frame.size.width = cell.bcView.frame.size.width - 10
        cell.emailLabel.frame.size.height = cell.bcView.frame.height / 7
        //cell.emailLabel.backgroundColor = .yellow
        cell.emailLabel.textAlignment = .center
        cell.emailLabel.font = UIFont.systemFont(ofSize: 15)
        cell.emailLabel.textColor = .gray
        
        cell.imageView.frame.size.width = cell.bcView.frame.size.width - 40
        cell.imageView.frame.size.height = cell.imageView.frame.width
        cell.imageView.contentMode = .scaleAspectFill
        cell.imageView.clipsToBounds = true
        
        cell.nameLabel.frame.origin.x = 5
        cell.nameLabel.center.y = cell.bcView.frame.height*3.6/5
        cell.emailLabel.frame.origin.x = 5
        cell.emailLabel.center.y = cell.bcView.frame.height*4.5/5
        cell.emailLabel.adjustsFontSizeToFitWidth = true
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
        else {
            cell.emailLabel.isHidden = false
                        
            if isSearching {
                cell.nameLabel.text = "\((searchClients[indexPath.row-1]["Name"] as! String) + " " + (searchClients[indexPath.row-1]["Surname"] as! String))"
                cell.emailLabel.text = "\(searchClients[indexPath.row-1]["Email"] as! String)"
                cell.imageView.image = searchClients[indexPath.row-1]["Image"] as? UIImage
            }
            else {
                cell.nameLabel.text = "\((clients[indexPath.row-1]["Name"] as! String) + " " + (clients[indexPath.row-1]["Surname"] as! String))"
                cell.emailLabel.text = "\(clients[indexPath.row-1]["Email"] as! String)"
                cell.imageView.image = clients[indexPath.row-1]["Image"] as? UIImage
            }
        }
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("cell clicked")
        let clientVC = SingleClientViewController()
        if indexPath.row == 0 {
            clientVC.clientEditing = true
        }
        else {
            if isSearching {
                clientVC.client = searchClients[indexPath.row-1]
            }
            else {
                clientVC.client = clients[indexPath.row-1]
            }
        }
        
        
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
            self.fetchClientImages()
            self.clientsCollectionView.reloadData()
            self.totalClientsLabel.text = "Total clients: \(self.clients.count)"
        })
    }
    
    func fetchClientImages() {
        
        let dispGroup = DispatchGroup()
        
        for client in 0..<clients.count {
            dispGroup.enter()
            clientsCollectionView.isUserInteractionEnabled = false
            let imageName = clients[client]["Image"] as! String
            // Create a reference to the file you want to download
            let imageRef = Storage.storage().reference().child("images/\(imageName)")

            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            imageRef.getData(maxSize: 1 * 1256 * 1256) { data, error in
              if let error = error {
                // Uh-oh, an error occurred!
                print("Error")
                print(error)
              } else {
                // Data for the image is returned
                self.clients[client]["Image"] = UIImage(data: data!)
                dispGroup.leave()
              }
            }
        }
        
        dispGroup.notify(queue: .main, execute: {
            self.clientsCollectionView.reloadData()
            self.clientsCollectionView.isUserInteractionEnabled = true
        })
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
