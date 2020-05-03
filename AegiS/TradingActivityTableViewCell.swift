//
//  TradingActivityTableViewCell.swift
//  AegiS
//
//  Created by Teodor Pavlov on 4/29/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

class TradingActivityTableViewCell: UITableViewCell {

    var dateLabel = UILabel()
    var securityName = UILabel()
    var type = UILabel()
    var amount = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(dateLabel)
        self.addSubview(securityName)
        self.addSubview(type)
        self.addSubview(amount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
