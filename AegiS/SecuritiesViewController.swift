//
//  SecuritiesViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/10/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SecuritiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var backgroundImage = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var backgroundImage1 = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var topBackgroundView = UIView()
    var bottomBackgroundView = UIView()
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    var securitiesTableView = UITableView()
    var searchBar = UISearchBar()
        
    var securities = [[String: AnyObject]]()
    var searchSecurities = [[String: AnyObject]]()
    var isSearching = false
    
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
        
        securitiesTableView.frame.size.width = self.view.frame.width - 50
        securitiesTableView.frame.size.height = self.view.frame.size.height*4.5/7
        securitiesTableView.frame.origin.x = 25
        securitiesTableView.frame.origin.y = self.view.frame.height - 83 - securitiesTableView.frame.height - 5
        securitiesTableView.backgroundColor = .clear
        securitiesTableView.delegate = self
        securitiesTableView.dataSource = self
        securitiesTableView.register(MainSecuritiesTableViewCell.self, forCellReuseIdentifier: "mainSecurity")
        securitiesTableView.separatorColor = .clear
        securitiesTableView.layer.cornerRadius = 10
        securitiesTableView.clipsToBounds = true
        securitiesTableView.showsVerticalScrollIndicator = false
        
        titleLabel.frame.size.width = self.view.frame.width
        titleLabel.frame.size.height = self.view.frame.height/15
        titleLabel.text = "SECURITIES"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.frame.origin.y = 40
        
        dateLabel.frame.size.width = self.view.frame.width
        dateLabel.frame.size.height = self.view.frame.height/20
        dateLabel.text = "date"
        dateLabel.textColor = .lightText
        dateLabel.textAlignment = .center
        dateLabel.font = UIFont.boldSystemFont(ofSize: 15)
        dateLabel.frame.origin.y = titleLabel.frame.origin.y + dateLabel.frame.height - 10
        
        let df = DateFormatter()
        df.dateFormat = "d MMM yyyy"
        let stringDate = df.string(from: Date())
        
        dateLabel.text = stringDate
        
        searchBar.frame.size.width = securitiesTableView.frame.width
        searchBar.frame.size.height = titleLabel.frame.height
        searchBar.frame.origin.y = dateLabel.frame.origin.y + dateLabel.frame.height + 10
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
        
        self.view.addSubview(topBackgroundView)
        topBackgroundView.addSubview(backgroundImage)
        self.view.addSubview(bottomBackgroundView)
        bottomBackgroundView.addSubview(backgroundImage1)
        self.view.addSubview(securitiesTableView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(dateLabel)
        self.view.addSubview(searchBar)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
        
        let ref = Database.database().reference()
        
        ref.child("securities").observeSingleEvent(of: .value, with: {(snapshot) in
            let s = snapshot.value as! [AnyObject]
            
            for sec in s {
                self.securities.append(sec as! [String : AnyObject])
            }
            
            print(self.securities)
            self.securitiesTableView.reloadData()
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            searchBar.showsCancelButton = true
            self.isSearching = true
            searchSecurities = securities.filter({($0["Short description"] as! String).lowercased().contains(searchText.lowercased())})
            self.securitiesTableView.reloadData()
        }
        else {
            self.isSearching = false
            self.securitiesTableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.text = ""
        searchBar.showsCancelButton = false
        isSearching = false
        securitiesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return searchSecurities.count
        }
        else {
            return securities.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainSecurity", for: indexPath) as! MainSecuritiesTableViewCell
        
        cell.backgroundColor = .clear
        cell.bcView.frame.size.width = cell.frame.width - 20
        cell.bcView.frame.size.height = cell.frame.height - 25
        cell.bcView.frame.origin.x = 10
        
        if cell.bcView.layer.sublayers?.count == 7 { // change if new views are added to bcView!
            cell.bcView.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 7.5), opacity: 0.8, shadowRadius: 5, cornerRadius: 10.0, corners: [.allCorners], fillColor: .white)
        }
        
        cell.bcView.addSubview(cell.title)
        cell.bcView.addSubview(cell.arrow)
        cell.bcView.addSubview(cell.price)
        cell.bcView.addSubview(cell.percentage)
        cell.bcView.addSubview(cell.graphView)
        cell.bcView.addSubview(cell.alert)
        cell.bcView.addSubview(cell.alertIcon)
        
        cell.title.frame.size.height = cell.bcView.frame.height/2 - 15
        cell.title.frame.size.width = cell.bcView.frame.width*3/5
        cell.title.frame.origin.x = 15
        cell.title.frame.origin.y = cell.bcView.frame.height/2
        cell.title.font = UIFont.boldSystemFont(ofSize: 15)
        cell.title.textAlignment = .left
        
        cell.percentage.frame.size.height = cell.title.frame.size.height
        cell.percentage.frame.size.width = cell.bcView.frame.width - 15 - 30 - cell.title.frame.width
        cell.percentage.frame.origin.x = cell.title.frame.origin.x + cell.title.frame.width
        cell.percentage.frame.origin.y = cell.title.frame.origin.y
        cell.percentage.textColor = .red
        cell.percentage.textAlignment = .center
        cell.percentage.text = "-%"
        
        cell.arrow.frame.size.height = cell.percentage.frame.height
        cell.arrow.frame.size.width = 15
        cell.arrow.frame.origin.x = cell.percentage.frame.origin.x + cell.percentage.frame.width
        cell.arrow.frame.origin.y = cell.percentage.frame.origin.y
        cell.arrow.image = UIImage(systemName: "arrow.up")
        cell.arrow.tintColor = .red
        cell.arrow.contentMode = .scaleAspectFit
        
        cell.price.frame.size.height = cell.bcView.frame.height/2 - 15
        cell.price.frame.size.width = cell.percentage.frame.width + cell.arrow.frame.width
        cell.price.frame.origin.x = 15
        cell.price.frame.origin.y = 15
        cell.price.textAlignment = .left
        cell.price.text = "price"
        cell.price.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.graphView.frame.size.width = cell.bcView.frame.width - cell.price.frame.width - 30
        cell.graphView.frame.size.height = cell.title.frame.height
        cell.graphView.frame.origin.y = 15
        cell.graphView.frame.origin.x = cell.price.frame.origin.x + cell.price.frame.width
        cell.graphView.backgroundColor = .green
        
        cell.alert.frame.size.height = cell.title.frame.height/2
        cell.alert.frame.size.width = cell.title.frame.width
        cell.alert.text = "Hold on this stock"
        cell.alert.sizeToFit()
        cell.alert.frame.origin.x = cell.bcView.frame.width - cell.alert.frame.size.width - 15
        cell.alert.frame.origin.y = cell.bcView.frame.height - cell.alert.frame.height - 5
        cell.alert.textAlignment = .right
        cell.alert.textColor = .lightGray
        cell.alert.font = UIFont.systemFont(ofSize: 15)
        
        cell.alertIcon.tintColor = UIColor.lightGray.withAlphaComponent(0.8)
        cell.alertIcon.frame.size.height = cell.alert.frame.height/1.5
        cell.alertIcon.frame.size.width = cell.alertIcon.frame.height
        cell.alertIcon.center.y = cell.alert.center.y
        cell.alertIcon.frame.origin.x = cell.alert.frame.origin.x - cell.alertIcon.frame.width - 5
        
        if isSearching {
            cell.title.text = searchSecurities[indexPath.row]["Short description"] as? String
            cell.price.text = "£\((searchSecurities[indexPath.row]["Price 5"] as! Int))"
            let percentageChange = ((searchSecurities[indexPath.row]["Price 5"] as! Double) - (searchSecurities[indexPath.row]["Price 4"] as! Double))/(searchSecurities[indexPath.row]["Price 4"] as! Double)*100
            cell.percentage.text = "\(String(format: "%.2f", percentageChange))%"
            
            if percentageChange >= 0 {
                cell.percentage.textColor = .green
            }
            else {
                cell.percentage.textColor = .red
            }
            
            if percentageChange > 10.00 || percentageChange < -10 {
                if percentageChange > 10.00 {
                    cell.alert.text = "Best time to sell"
                }
                else {
                    cell.alert.text = "Best time to buy"
                }
            }
            else {
                cell.alert.text = "Hold on this stock"
            }
            cell.alert.sizeToFit()
            cell.alert.frame.origin.x = cell.bcView.frame.width - cell.alert.frame.size.width - 15
            cell.alert.frame.origin.y = cell.bcView.frame.height - cell.alert.frame.height - 5
            
            cell.alertIcon.frame.size.height = cell.alert.frame.height/1.5
            cell.alertIcon.frame.size.width = cell.alertIcon.frame.height
            cell.alertIcon.center.y = cell.alert.center.y
            cell.alertIcon.frame.origin.x = cell.alert.frame.origin.x - cell.alertIcon.frame.width - 5
            
            if (searchSecurities[indexPath.row]["Price 5"] as! Int) >= (searchSecurities[indexPath.row]["Price 4"] as! Int) { // price going up
                cell.arrow.tintColor = .green
            }
            else {
                cell.arrow.tintColor = .red
            }
            
        }
        else {
            cell.title.text = securities[indexPath.row]["Short description"] as? String
            cell.price.text = "£\((securities[indexPath.row]["Price 5"] as! Int))"
            let percentageChange = ((securities[indexPath.row]["Price 5"] as! Double) - (securities[indexPath.row]["Price 4"] as! Double))/(securities[indexPath.row]["Price 4"] as! Double)*100
            cell.percentage.text = "\(String(format: "%.2f", percentageChange))%"
            
            if percentageChange >= 0 {
                cell.percentage.textColor = .green
            }
            else {
                cell.percentage.textColor = .red
            }
            
            if percentageChange > 10.00 || percentageChange < -10 {
                if percentageChange > 10.00 {
                    cell.alert.text = "Best time to sell"
                }
                else {
                    cell.alert.text = "Best time to buy"
                }
            }
            else {
                cell.alert.text = "Hold on this stock"
            }
            cell.alert.sizeToFit()
            cell.alert.frame.origin.x = cell.bcView.frame.width - cell.alert.frame.size.width - 15
            cell.alert.frame.origin.y = cell.bcView.frame.height - cell.alert.frame.height - 5
            
            cell.alertIcon.frame.size.height = cell.alert.frame.height/1.5
            cell.alertIcon.frame.size.width = cell.alertIcon.frame.height
            cell.alertIcon.center.y = cell.alert.center.y
            cell.alertIcon.frame.origin.x = cell.alert.frame.origin.x - cell.alertIcon.frame.width - 5
            
            if (securities[indexPath.row]["Price 5"] as! Int) >= (securities[indexPath.row]["Price 4"] as! Int) { // price going up
                cell.arrow.tintColor = .green
            }
            else {
                cell.arrow.tintColor = .red
                cell.arrow.transform = CGAffineTransform(rotationAngle: .pi)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
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
