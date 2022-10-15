//
//  Extensions.swift
//  TestTask
//
//  Created by Артем Пашевич on 14.10.22.
//

import UIKit

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return UIImage(data: data)
        }
        return nil
    }
}
