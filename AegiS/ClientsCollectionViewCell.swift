//
//  ClientsCollectionViewCell.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/18/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

class ClientsCollectionViewCell: UICollectionViewCell {
    
    var nameLabel = UILabel()
    var bcView = UIView()
    var emailLabel = UILabel()
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(bcView)
        bcView.addSubview(nameLabel)
        bcView.addSubview(emailLabel)
        bcView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
