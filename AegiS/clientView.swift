//
//  clientView.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/11/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

class clientView: UIView {

    var nameLabel = UILabel()
    var emailLabel = UILabel()
    var imageView = UIImageView()
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        nameLabel.frame.size.width = self.frame.size.width - 10
        nameLabel.frame.size.height = self.frame.height / 7
        //nameLabel.backgroundColor = .red
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 20)
        
        emailLabel.frame.size.width = self.frame.size.width - 10
        emailLabel.frame.size.height = self.frame.height / 7
        //emailLabel.backgroundColor = .yellow
        emailLabel.textAlignment = .center
        emailLabel.font = UIFont.systemFont(ofSize: 15)
        emailLabel.textColor = .gray
        
        imageView.frame.size.width = self.frame.size.width - 40
        imageView.frame.size.height = imageView.frame.width
        imageView.backgroundColor = .white
        
        //self.clipsToBounds = true
        //self.layer.cornerRadius = 10
        self.addSubview(nameLabel)
        self.addSubview(imageView)
        self.addSubview(emailLabel)
    }

}


extension UIView {
    
    func addShadow(shadowColor: UIColor, offSet: CGSize, opacity: Float, shadowRadius: CGFloat, cornerRadius: CGFloat, corners: UIRectCorner, fillColor: UIColor = .white) {
        
        let shadowLayer = CAShapeLayer()
        let size = CGSize(width: cornerRadius, height: cornerRadius)
        let cgPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: size).cgPath //1
        shadowLayer.path = cgPath //2
        shadowLayer.fillColor = fillColor.cgColor //3
        shadowLayer.shadowColor = shadowColor.cgColor //4
        shadowLayer.shadowPath = cgPath
        shadowLayer.shadowOffset = offSet //5
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        self.layer.addSublayer(shadowLayer)
    }
}
