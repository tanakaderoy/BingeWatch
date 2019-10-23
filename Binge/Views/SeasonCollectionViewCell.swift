//
//  SeasonCollectionViewCell.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/3/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//

import UIKit

class SeasonCollectionViewCell: UICollectionViewCell {
    
    let seasonPosterImageView: UIImageView = {
        let iv = UIImageView()

        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        //iv.layer.cornerRadius = 12
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.addSubview(seasonPosterImageView)

        seasonPosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        seasonPosterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        seasonPosterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        seasonPosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
