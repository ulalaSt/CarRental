//
//  PhotoService.swift
//  Car Rent (Beeline)
//
//  Created by user on 18.05.2022.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoService {
    static func getImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        AF.request(url, method: .get).responseImage { (response) in
            switch response.result {
            case .success(let image):
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
