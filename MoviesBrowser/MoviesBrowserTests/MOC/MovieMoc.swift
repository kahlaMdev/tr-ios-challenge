//
//  MovieMoc.swift
//  MoviesBrowserTests
//
//  Created by Mohamed Kahla on 2021-10-04.
//

import Foundation
import UIKit

struct  MovieMoc:MovieProtocol {
    
    var identifier: Int16
    
    var name: String
    
    var descript: String
    
    var plot: String
    
    var releaseDateEpochTime: Int64
    
    var rating: Float
    
    var year: Int16
    
    var picture: String?
    
    var thumbnail: String?
    
    var pictureImage:UIImage?
    
    var thumbnailImage:UIImage?
    
    var recommendedIDs: Array<Int16>?
    
}
