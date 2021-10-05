//
//  MovieProtocol.swift
//  MoviesBrowser
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation
import UIKit

public protocol MovieProtocol {
    
    var identifier: Int16 { get set }
    var name: String { get set }
    var descript: String { get set }
    var plot: String { get set }
    var releaseDateEpochTime: Int64 { get set }
    var rating: Float { get set }
    var year: Int16 { get set }
    
    // URL String of picture image
    var picture: String? { get set }
    
    // URL String of thumbnail image
    var thumbnail: String? { get set }
    
    var pictureImage:UIImage?  { get }
    
    var thumbnailImage:UIImage?  { get }
    
    // The list of recommended Movies IDs!
    var recommendedIDs: Array<Int16>? { get set }
}
