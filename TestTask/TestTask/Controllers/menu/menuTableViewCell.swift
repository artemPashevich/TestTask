//
//  menuTableViewCell.swift
//  TestTask
//
//  Created by Артем Пашевич on 14.10.22.
//

import UIKit

final class menuTableViewCell: UITableViewCell {
    @IBOutlet var nameProduct: UILabel!
    @IBOutlet var descriptionProduct: UILabel!
    @IBOutlet var imageProduct: UIImageView!
    @IBOutlet var priceBtn: UIButton!
    
    func btnStyle() {
        priceBtn.layer.borderColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1).cgColor
        priceBtn.layer.borderWidth = 1
        priceBtn.layer.cornerRadius = 6
    }
}
