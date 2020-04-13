//
//  SingleSecurityInfoTableViewCell.swift
//  AegiS
//
//  Created by Teodor Pavlov on 4/10/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

class SingleSecurityInfoTableViewCell: UITableViewCell {

    var dateLabel = UITextField()
    var priceLabel = UITextField()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(dateLabel)
        self.addSubview(priceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
