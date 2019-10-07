//
//  TvShowTableViewCell.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/1/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//

import UIKit

class TvShowTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var tvShowNameLabel: UILabel!
    @IBOutlet weak var tvShowFirstAirdateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class TvShowSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var searchPosterImageView: UIImageView!
    @IBOutlet weak var searchSummaryTextView: UILabel!
    @IBOutlet weak var tvShowSearchNameLabel: UILabel!
    @IBOutlet weak var tvShowSearchFirstAirdateLabel: UILabel!
    @IBOutlet weak var ratingSearchLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
