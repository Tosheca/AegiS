//
//  SecurityViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 4/8/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

class SecurityViewController: UIViewController {

    var backgroundImage = UIImageView(image: UIImage(named: "49054316_356857088449911_3489275029483421696_n.jpg"))
    var topBackgroundView = UIView()
    
    var backButton = UIButton()
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    var graphView = UIView()
    var priceLabel = UILabel()
    var percentageLabel = UILabel()
    
    var security = [String: AnyObject]()
    
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
        
        backButton.frame.size.width = self.view.frame.width/6
        backButton.frame.size.height = backButton.frame.width/2
        backButton.frame.origin.y = 50
        backButton.setTitle("BACK", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
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
        
        graphView.frame.size.width = topBackgroundView.frame.width - 50
        graphView.frame.size.height = topBackgroundView.frame.height/2
        graphView.backgroundColor = .green
        graphView.frame.origin.x = 25
        graphView.frame.origin.y = dateLabel.frame.origin.y + dateLabel.frame.height + 50
        
        priceLabel.text = "£\((security["Price 5"] as! Int))"
        priceLabel.font = UIFont.boldSystemFont(ofSize: 25)
        priceLabel.sizeToFit()
        priceLabel.frame.origin.x = 25
        priceLabel.frame.origin.y = graphView.frame.origin.y + graphView.frame.height + 25
        priceLabel.textAlignment = .left
        priceLabel.textColor = .white
        
        let percentageChange = ((security["Price 5"] as! Double) - (security["Price 4"] as! Double))/(security["Price 4"] as! Double)*100
        percentageLabel.text = "\(String(format: "%.2f", percentageChange))%"
        percentageLabel.font = UIFont.systemFont(ofSize: 15)
        
        
        if percentageChange >= 0 {
            percentageLabel.text = "+" + percentageLabel.text!
        }
        
        percentageLabel.sizeToFit()
        percentageLabel.center.y = priceLabel.center.y
        percentageLabel.frame.origin.x = priceLabel.frame.origin.x + priceLabel.frame.width + 25
        percentageLabel.textColor = .white
        
        self.view.addSubview(topBackgroundView)
        topBackgroundView.addSubview(backgroundImage)
        topBackgroundView.addSubview(backButton)
        topBackgroundView.addSubview(titleLabel)
        topBackgroundView.addSubview(dateLabel)
        topBackgroundView.addSubview(graphView)
        topBackgroundView.addSubview(priceLabel)
        topBackgroundView.addSubview(percentageLabel)
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
