//
//  menuBarCollectionViewCell.swift
//  TestTask
//
//  Created by Артем Пашевич on 14.10.22.
//

import UIKit

final class menuBarCollectionViewCell: UICollectionViewCell {
    @IBOutlet var nameCatigories: UILabel!
    
    func chooseStyle() {
        nameCatigories.backgroundColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 0.4)
        nameCatigories.textColor = UIColor(red: 0.992, green: 0.227, blue: 0.412, alpha: 1)
        nameCatigories.font = UIFont(name: "SFUIDisplay-Bold", size: 17)
    }
    
    func defaultStule() {
        nameCatigories.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
}
