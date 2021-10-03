//
//  UIImage+URL.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-03.
//

import Foundation
import UIKit

extension UIImage {
    static func downloadImage(_ url: String) -> (data: Data? , image: UIImage?) {
        let aUrl = URL(string: url)
        guard let data = try? Data(contentsOf: aUrl!),
              let image = UIImage(data: data) else {
            return (nil , nil)
        }
        return (data, image)
    }
}
