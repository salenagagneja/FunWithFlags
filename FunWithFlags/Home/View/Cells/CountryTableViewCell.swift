//
//  CountryTableViewCell.swift
//  FunWithFlags
//
//  Created by Richmond Ko on 7/8/21.
//

import UIKit
import Kingfisher

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with country: Country) {
        countryNameLabel.text = country.name
        
        if let alpha2Code = country.alpha2Code {
            flagImageView.image = UIImage(named: "\(alpha2Code.lowercased()).png")
        }
    }
}
