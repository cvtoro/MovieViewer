//
//  MovieCell.swift
//  MovieViewer
//
//  Created by Cecilia  Villatoro on 1/11/17.
//  Copyright © 2017 Cecilia. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var posterView: UIImageView!
    @IBOutlet var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
