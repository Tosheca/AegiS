//
//  SecuritiesViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/10/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

class SecuritiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var backgroundImage = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var backgroundImage1 = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var topBackgroundView = UIView()
    var bottomBackgroundView = UIView()
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    var securitiesTableView = UITableView()
    var searchBar = UISearchBar()
    
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
        //titleLabel.backgroundColor = .green
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.frame.origin.y = 40
        
        dateLabel.frame.size.width = self.view.frame.width
        dateLabel.frame.size.height = self.view.frame.height/20
        dateLabel.text = "date"
        dateLabel.textColor = .lightText
        dateLabel.textAlignment = .center
        //dateLabel.backgroundColor = .red
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainSecurity", for: indexPath) as! MainSecuritiesTableViewCell
        
        cell.backgroundColor = .clear
        cell.bcView.frame.size.width = cell.frame.width - 20
        cell.bcView.frame.size.height = cell.frame.height - 25
        cell.bcView.frame.origin.x = 10
        
        if cell.bcView.layer.sublayers?.count == 4 {
            cell.bcView.addShadow(shadowColor: .darkGray, offSet: CGSize(width: 0, height: 7.5), opacity: 0.8, shadowRadius: 5, cornerRadius: 10.0, corners: [.allCorners], fillColor: .white)
        }
        
        cell.bcView.addSubview(cell.title)
        cell.bcView.addSubview(cell.arrow)
        cell.bcView.addSubview(cell.price)
        cell.bcView.addSubview(cell.percentage)
        
        cell.title.frame.size.height = cell.bcView.frame.height
        cell.title.frame.size.width = cell.bcView.frame.width*3/5
        cell.title.frame.origin.x = 15
        cell.title.text = "title"
        cell.title.font = UIFont.boldSystemFont(ofSize: 15)
        
        cell.arrow.frame.size.height = cell.bcView.frame.height
        cell.arrow.frame.size.width = 30
        cell.arrow.frame.origin.x = cell.bcView.frame.width - 40
        cell.arrow.image = UIImage(systemName: "arrow.up")
        cell.arrow.tintColor = .red
        cell.arrow.contentMode = .scaleAspectFit
        
        cell.price.frame.size.height = cell.bcView.frame.height/3
        cell.price.frame.size.width = cell.bcView.frame.width - cell.arrow.frame.width - 10 - cell.title.frame.width - 15
        cell.price.frame.origin.x = cell.title.frame.origin.x + cell.title.frame.width
        cell.price.frame.origin.y = 15
        cell.price.textAlignment = .center
        cell.price.text = "price"
        cell.price.font = UIFont.boldSystemFont(ofSize: 20)
        
        cell.percentage.frame.size = cell.price.frame.size
        cell.percentage.frame.origin.x = cell.price.frame.origin.x
        cell.percentage.frame.origin.y = cell.price.frame.origin.y + cell.price.frame.height
        cell.percentage.textColor = .red
        cell.percentage.textAlignment = .center
        cell.percentage.text = "-%"
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = .clear
//        headerView.frame.size.width = securitiesTableView.frame.width
//        headerView.frame.size.height = 20
//        return headerView
//    }
    
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
