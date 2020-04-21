//
//  SecurityViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 4/8/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit
import SwiftChart

class SecurityViewController: UIViewController, ChartDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var backgroundImage = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var topBackgroundView = UIView()
    
    var backButton = UIButton()
    var titleLabel = UILabel()
    var todayDateLabel = UILabel()
    var graphView = UIView()
    var securityPriceLabel = UILabel()
    var percentageLabel = UILabel()
    var alert = UILabel()
    var alertIcon = UIImageView()
    var line1 = UIView()
    var line2 = UIView()
    var infoTableView = UITableView()
    var security = [String: AnyObject]()
    
    var chartView = Chart()
    var chartPriceLabel = UILabel()
    var pricesCount = Int()
    var editingPrices = false
    var hasErrors = false
    var priceAdded = false
    
    var dates = [String]()
    
    var changedTextFields = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.edgesForExtendedLayout = []
        self.view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        
        backgroundImage.frame.size.width = self.view.frame.size.width
        backgroundImage.frame.size.height = self.view.frame.size.height
        backgroundImage.contentMode = .scaleAspectFill
        
        topBackgroundView.frame.size.width = self.view.frame.size.width
        topBackgroundView.frame.size.height = self.view.frame.size.height*5/7
        topBackgroundView.clipsToBounds = true
        topBackgroundView.layer.cornerRadius = 40
        topBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        backButton.frame.size.width = self.view.frame.width/10
        backButton.frame.size.height = backButton.frame.width
        backButton.frame.origin.y = 50
        backButton.frame.origin.x = 10
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        backButton.tintColor = .white
        
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium)
        let homeImage = UIImage(systemName: "arrow.uturn.left", withConfiguration: homeSymbolConfiguration)
        backButton.setImage(homeImage, for: .normal)
        
        titleLabel.frame.size.width = self.view.frame.width - 50
        titleLabel.frame.size.height = self.view.frame.height/15
        titleLabel.center.x = self.view.frame.width/2
        titleLabel.frame.origin.y = backButton.frame.origin.y + backButton.frame.height
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.text = "Security Name"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.text = security["Short description"] as? String
        titleLabel.adjustsFontSizeToFitWidth = true
        
        todayDateLabel.frame.size.width = self.view.frame.width
        todayDateLabel.frame.size.height = self.view.frame.height/20
        todayDateLabel.text = "date"
        todayDateLabel.textColor = .lightText
        todayDateLabel.textAlignment = .center
        todayDateLabel.font = UIFont.boldSystemFont(ofSize: 15)
        todayDateLabel.frame.origin.y = titleLabel.frame.origin.y + titleLabel.frame.height - 20
        
        let df = DateFormatter()
        df.dateFormat = "d MMM yyyy"
        let stringDate = df.string(from: Date())
        
        todayDateLabel.text = stringDate
        
        graphView.frame.size.width = topBackgroundView.frame.width
        graphView.frame.size.height = topBackgroundView.frame.width
        //graphView.backgroundColor = .green
        graphView.frame.origin.x = 0
        graphView.frame.origin.y = todayDateLabel.frame.origin.y + todayDateLabel.frame.height
        
        for key in security.keys {
            if key.suffix(4) != "Date" && key.prefix(5) == "Price" {
                pricesCount = pricesCount + 1
            }
        }
        
        chartView = Chart(frame: CGRect(x: 0, y: 0, width: graphView.frame.width - 100, height: graphView.frame.height - 50))
        chartView.frame.origin.x = 50
        chartView.frame.origin.y = 25
        chartView.labelColor = .white
        chartView.gridColor = .white
        chartView.axesColor = .white
        chartView.xLabelsSkipLast = false
        chartView.xLabelsTextAlignment = .left
        chartView.delegate = self
        
        // 153 days from 1st of August to 31st December
        
        var xValues = [Double]()
        let months = [0, 31, 61, 92, 122]
        for date in 1...5 {
            let testDate = security["Price \(date) Date"] as! String
            dates.append(testDate)
            print(testDate)
            let firstIndex = testDate.index(after: testDate.firstIndex(of: "/")!)
            let lastIndex = testDate.lastIndex(of: "/")!
            let range = firstIndex..<lastIndex
            let day = Int(testDate[range])
            xValues.append(Double((day! + months[date-1])))
        }
        
        print(xValues)
        chartView.xLabels = xValues
        
        let data = [(x: xValues[0], y: security["Price 1"] as! Double), (x: xValues[1], y: security["Price 2"] as! Double), (x: xValues[2], y: security["Price 3"] as! Double), (x: xValues[3], y: security["Price 4"] as! Double), (x: xValues[4], y: security["Price 5"] as! Double)]
        let series = ChartSeries(data: data)
        series.area = true
        series.color = .white
        chartView.add(series)
        chartView.minY = 0
        chartView.yLabelsFormatter = {"£" + String(Int($1))}
        chartView.xLabelsFormatter = {
            var label = self.dates[xValues.firstIndex(of: Double($1))!]
            label.removeLast(3)
            return label
        }
        graphView.addSubview(chartView)
        
        chartPriceLabel.font = UIFont.boldSystemFont(ofSize: 15)
        chartPriceLabel.isHidden = true
        chartPriceLabel.textColor = .white
        graphView.addSubview(chartPriceLabel)
        
        line1.frame.size.width = topBackgroundView.frame.width/2.5
        line1.frame.size.height = 2
        line1.frame.origin.y = graphView.frame.origin.y + graphView.frame.height - 10
        line1.frame.origin.x = 0
        line1.backgroundColor = .white
        
        line2.frame.size.width = topBackgroundView.frame.width/2.5
        line2.frame.size.height = 2
        line2.frame.origin.y =  graphView.frame.origin.y + graphView.frame.height - 10
        line2.frame.origin.x = self.view.frame.width - line2.frame.width
        line2.backgroundColor = .white
        
        securityPriceLabel.text = "£\((security["Price 5"] as! Int))"
        securityPriceLabel.font = UIFont.boldSystemFont(ofSize: 25)
        securityPriceLabel.sizeToFit()
        securityPriceLabel.frame.origin.x = 25
        securityPriceLabel.frame.origin.y = line1.frame.origin.y + line1.frame.height + 10
        securityPriceLabel.textAlignment = .left
        securityPriceLabel.textColor = .white
        
        let percentageChange = ((security["Price 5"] as! Double) - (security["Price 4"] as! Double))/(security["Price 4"] as! Double)*100
        percentageLabel.text = "\(String(format: "%.2f", percentageChange))%"
        percentageLabel.font = UIFont.systemFont(ofSize: 15)
        
        
        if percentageChange >= 0 {
            percentageLabel.text = "+" + percentageLabel.text!
        }
        
        percentageLabel.sizeToFit()
        percentageLabel.center.y = securityPriceLabel.center.y
        percentageLabel.frame.origin.x = securityPriceLabel.frame.origin.x + securityPriceLabel.frame.width + 25
        percentageLabel.textColor = .white
        
        if percentageChange > 10.00 || percentageChange < -10 {
            if percentageChange > 10.00 {
                alert.text = "Best time to sell"
            }
            else {
                alert.text = "Best time to buy"
            }
        }
        else {
            alert.text = "Hold on this stock"
        }
        alert.sizeToFit()
        alert.frame.origin.x = topBackgroundView.frame.width - alert.frame.size.width - 25
        alert.center.y = securityPriceLabel.center.y
        alert.textColor = .white
        
        alertIcon = UIImageView(image: UIImage(systemName: "flag.fill"))
        alertIcon.tintColor = .white
        alertIcon.frame.size.height = alert.frame.height/1.5
        alertIcon.frame.size.width = alertIcon.frame.height
        alertIcon.center.y = alert.center.y
        alertIcon.frame.origin.x = alert.frame.origin.x - alertIcon.frame.width - 5
        
        infoTableView.frame.size.height = self.view.frame.height - topBackgroundView.frame.height - 50
        infoTableView.frame.size.width = self.view.frame.width - 100
        infoTableView.frame.origin.x = 50
        infoTableView.frame.origin.y = topBackgroundView.frame.origin.y + topBackgroundView.frame.height + 25
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.register(SingleSecurityInfoTableViewCell.self, forCellReuseIdentifier: "singleSecurity")
        infoTableView.showsVerticalScrollIndicator = false
        infoTableView.layer.cornerRadius = 10
        infoTableView.clipsToBounds = true
        
        self.view.addSubview(topBackgroundView)
        topBackgroundView.addSubview(backgroundImage)
        topBackgroundView.addSubview(backButton)
        topBackgroundView.addSubview(titleLabel)
        topBackgroundView.addSubview(todayDateLabel)
        topBackgroundView.addSubview(graphView)
        topBackgroundView.addSubview(securityPriceLabel)
        topBackgroundView.addSubview(percentageLabel)
        topBackgroundView.addSubview(alert)
        topBackgroundView.addSubview(alertIcon)
        topBackgroundView.addSubview(line1)
        topBackgroundView.addSubview(line2)
        self.view.addSubview(infoTableView)
    }
    
    func didTouchChart(_ chart: Chart, indexes: [Int?], x: Double, left: CGFloat) {
        for (seriesIndex, dataIndex) in indexes.enumerated() {
          if dataIndex != nil {
            // The series at `seriesIndex` is that which has been touched
            let value = chart.valueForSeries(seriesIndex, atIndex: dataIndex)! as Double
            print(value)
            chartPriceLabel.text = "£\(value)"
            chartPriceLabel.sizeToFit()
            chartPriceLabel.center.x = left + 50
            chartPriceLabel.frame.origin.y = 0
            chartPriceLabel.isHidden = false
          }
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    func setupChart() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pricesCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "singleSecurity", for: indexPath) as! SingleSecurityInfoTableViewCell
        
        cell.selectionStyle = .none
        
        cell.dateLabel.frame.size.height = cell.frame.height/2
        cell.dateLabel.frame.size.width = (cell.frame.width-50)/2 - 12.5
        cell.dateLabel.frame.origin.x = 25
        cell.dateLabel.center.y = cell.frame.height/2
        cell.dateLabel.textColor = .black
        cell.dateLabel.textAlignment = .left
        cell.dateLabel.layer.cornerRadius = 5
        cell.dateLabel.clipsToBounds = true
        cell.dateLabel.accessibilityIdentifier = "date"
        cell.dateLabel.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        cell.priceLabel.frame.size.height = cell.frame.height/2
        cell.priceLabel.frame.size.width = (cell.frame.width-50)/2 - 12.5
        cell.priceLabel.frame.origin.x = cell.dateLabel.frame.origin.x + cell.dateLabel.frame.width + 25
        cell.priceLabel.center.y = cell.frame.height/2
        cell.priceLabel.textColor = .black
        cell.priceLabel.textAlignment = .right
        cell.priceLabel.layer.cornerRadius = 5
        cell.priceLabel.clipsToBounds = true
        cell.priceLabel.accessibilityIdentifier = "price"
        cell.priceLabel.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        cell.priceLabel.keyboardType = .numberPad
        
        if indexPath.row == pricesCount && priceAdded == false {
            cell.dateLabel.frame.size.width = cell.frame.width - 50
            cell.dateLabel.center.x = cell.frame.width/2
            cell.dateLabel.textAlignment = .center
            cell.dateLabel.text = "Edit prices"
            cell.priceLabel.isHidden = true
            if editingPrices {
                cell.dateLabel.text = "+ Add price"
            }
            cell.dateLabel.isEnabled = false
            cell.dateLabel.backgroundColor = .white
            cell.priceLabel.backgroundColor = .white
        }
        else if indexPath.row == pricesCount + 1 {
            cell.dateLabel.frame.size.width = cell.frame.width - 50
            cell.dateLabel.center.x = cell.frame.width/2
            cell.dateLabel.textAlignment = .center
            cell.dateLabel.text = "Done"
            cell.priceLabel.isHidden = true
            cell.dateLabel.isEnabled = false
            cell.dateLabel.backgroundColor = .white
            cell.priceLabel.backgroundColor = .white
        }
        else {
            cell.dateLabel.text = "\(security["Price \(indexPath.row+1) Date"] as! String)"
            cell.priceLabel.text = "£\(security["Price \(indexPath.row+1)"] as! Int)"
            cell.priceLabel.isHidden = false
            
            if editingPrices == false {
                cell.dateLabel.isEnabled = false
                cell.priceLabel.isEnabled = false
                cell.dateLabel.backgroundColor = .white
                cell.priceLabel.backgroundColor = .white
            }
            else {
                cell.dateLabel.isEnabled = true
                cell.dateLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.25)
                cell.priceLabel.isEnabled = true
                cell.priceLabel.backgroundColor = UIColor.darkGray.withAlphaComponent(0.25)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tableView.cellForRow(at: indexPath) as! SingleSecurityInfoTableViewCell).dateLabel.text == "Edit prices" {
            editingPrices = true
            hasErrors = false
            tableView.reloadData()
        }
        else if (tableView.cellForRow(at: indexPath) as! SingleSecurityInfoTableViewCell).dateLabel.text == "Done" {
            
            if hasErrors == false {
                editingPrices = false
                priceAdded = false
                pricesCount = 0
                for key in security.keys {
                    if key.suffix(4) != "Date" && key.prefix(5) == "Price" {
                        pricesCount = pricesCount + 1
                    }
                }
                
                
                for textField in changedTextFields {
                    
                }
                
                tableView.reloadData()
            }
            else {
                print("errors")
            }
        }
        else if (tableView.cellForRow(at: indexPath) as! SingleSecurityInfoTableViewCell).dateLabel.text == "+ Add price" {
            print("HERE 1")

            security["Price \(pricesCount+1)"] = 0 as AnyObject
            security["Price \(pricesCount+1) Date"] = "1/1/19" as AnyObject
            print(pricesCount+1)
            priceAdded = true
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
//        if editingPrices {
//            if indexPath.row == pricesCount + 1 {
//                if hasErrors == false {
//                    editingPrices = false
//                    priceAdded = false
//                    for key in security.keys {
//                        if key.suffix(4) != "Date" && key.prefix(5) == "Price" {
//                            pricesCount = pricesCount + 1
//                        }
//                    }
//                    tableView.reloadData()
//                    print("here?")
//                }
//                else {
//                    print("errors")
//                }
//            }
//            else if indexPath.row == pricesCount {
//
//                if (tableView.cellForRow(at: indexPath) as! SingleSecurityInfoTableViewCell).dateLabel.text == "+ Add price" {
//                    print("HERE 1")
//
//                    security["Price \(pricesCount+1)"] = 0 as AnyObject
//                    security["Price \(pricesCount+1) Date"] = "1/1/19" as AnyObject
//                    print(pricesCount+1)
//                    priceAdded = true
//                    tableView.reloadRows(at: [indexPath], with: .none)
//                }
//                else { // when the cell is "Done"
//                    print("2")
//                }
////                let dateFomatter = DateFormatter()
////                dateFomatter.dateFormat = "M/d/yy"
////
////                let dateCounter = 0
////                for dateString in dates {
////                    print(dateString)
////                    let date = dateFomatter.date(from: dateString)
////
////
////                }
////
////                tableView.beginUpdates()
////                tableView.insertRows(at: [indexPath], with: .automatic)
////                pricesCount = pricesCount + 1
////                for value in 0..<pricesCount-indexPath.row {
////                    print(value)
////                }
////                security["Price \(pricesCount)"] = 0 as AnyObject
////                security["Price \(pricesCount) Date"] = "1/1/19" as AnyObject
////                tableView.endUpdates()
//            }
//            else {
//
//            }
//        }
//        else {
//            if indexPath.row == pricesCount {
//                editingPrices = true
//                tableView.reloadData()
//            }
//        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == pricesCount || indexPath.row == pricesCount + 1 {
            return false
        }
        else {
            return editingPrices
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("delete")
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            for value in indexPath.row+1...pricesCount {
                print(value)
                security["Price \(value)"] = security["Price \(value+1)"]
                security["Price \(value) Date"] = security["Price \(value+1) Date"]
            }
            security.removeValue(forKey: "Price \(pricesCount)")
            security.removeValue(forKey: "Price \(pricesCount) Date")
            dates.remove(at: indexPath.row)
            pricesCount = pricesCount - 1
            tableView.endUpdates()
            print(security)
            print(dates)
        }
    }

    @objc func textFieldDidChange(textField: UITextField) {
        changedTextFields.append(textField)
        if textField.accessibilityIdentifier == "date" {
            var characterCount = 0
            for character in textField.text! {
                if character == "/" {
                    characterCount = characterCount + 1
                }
            }
            
            if characterCount == 2 {
                hasErrors = false
                textField.textColor = .black
            }
            else {
                hasErrors = true
                textField.textColor = .red
            }
        }
        else if textField.accessibilityIdentifier == "price" {
            if textField.text?.contains("£") == false {
                textField.text = "£" + textField.text!
            }
            
            if textField.text == "£" {
                textField.textColor = .red
                hasErrors = true
            }
            else {
                hasErrors = false
                textField.textColor = .black
            }
        }
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
