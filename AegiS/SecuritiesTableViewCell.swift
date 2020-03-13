//
//  SecuritiesTableViewCell.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/12/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

class SecuritiesTableViewCell: UITableViewCell {

    var title = UILabel()
    var price = UILabel()
    var arrow = UIImageView()
    var percentage = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.addSubview(title)
        self.addSubview(arrow)
        self.addSubview(price)
        self.addSubview(percentage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
