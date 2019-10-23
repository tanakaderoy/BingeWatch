//
//  ProviderTableViewCell.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 10/4/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//

import UIKit

class ProviderTableViewCell: UITableViewCell {
    @IBOutlet weak var providerNameLabel: UILabel!
    var providerURL: String = ""
    var standardWeb = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func openLickTapped(_ sender: UIButton) {
        print("provider", providerURL)
        if  UIApplication.shared.canOpenURL(URL(string: providerURL)!){
            UIApplication.shared.open(URL(string: providerURL)!, options: [:], completionHandler: nil)
        }else{
            UIApplication.shared.openURL(URL(string: standardWeb)!)
        }
    }
}
