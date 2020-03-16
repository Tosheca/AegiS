//
//  MainSecuritiesTableViewCell.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/16/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

class MainSecuritiesTableViewCell: UITableViewCell {

    var title = UILabel()
    var price = UILabel()
    var arrow = UIImageView()
    var percentage = UILabel()
    var bcView = UIView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        
        bcView.addSubview(title)
        bcView.addSubview(arrow)
        bcView.addSubview(price)
        bcView.addSubview(percentage)
        self.addSubview(bcView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
