//
//  NetworkService.swift
//  TestTask
//
//  Created by Артем Пашевич on 14.10.22.
//

import Foundation
import Alamofire
import SwiftyJSON

final class NetworkService {
    static func getProduct(callback: @escaping (_ result: JSON?, _ error: Error?) -> Void) {
        //let url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&page=2&api_key=TkbXtoBn0GDUbmUQwRaK8VhgDa43CFY1NnX1tZNx"
        let url = "https://api.punkapi.com/v2/beers"

        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                var jsonValue: JSON?
                var err: Error?

                switch response.result {
                    case .success(let data):
                        jsonValue = JSON(data)
                    case .failure(let error):
                        err = error
                }
                callback(jsonValue, err)
            }
    }
}
