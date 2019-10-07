//
//  EpisodeTableViewCell.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/3/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeAirdateLabel: UILabel!
    @IBOutlet weak var episodeOverViewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
