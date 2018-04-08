//
//  ViewCell.swift
//  Realm_Sample
//
//  Created by AtsushiSaito on 2018/04/08.
//  Copyright © 2018年 AtsushiSaito. All rights reserved.
//

import UIKit

class ViewCell: UITableViewCell {
    var Name: UILabel!
    var Old: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.Name = UILabel(frame: CGRect.zero)
        self.Name.textAlignment = .left
        self.Name.font = UIFont.systemFont(ofSize: 16)
        
        self.Old = UILabel(frame: CGRect.zero)
        self.Old.textAlignment = .left
        self.Old.font = UIFont.systemFont(ofSize: 13)
        
        contentView.addSubview(self.Name)
        contentView.addSubview(self.Old)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.Name.frame = CGRect(x: 10, y: -30, width: frame.width - 20, height: frame.height)
        self.Old.frame = CGRect(x: 10, y: -10, width: frame.width-20, height: frame.height)
    }
}

